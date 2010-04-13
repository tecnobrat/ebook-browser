class ProcessEbook
  @queue = ("process_ebook").to_sym

  def self.perform(file_name)
    meta = get_ebook_metadata(file_name)
    book = Book.find_by_isbn(meta[:isbn])
    if book.nil?
      throw "Need either ISBN or Title and Author\n#{meta.inspect}" if meta[:isbn].nil? and (meta[:title].nil? or meta[:author].nil?)
      author = Author.find_or_create_by_name(meta[:author].titleize) unless meta[:author].nil?
      publisher = Publisher.find_or_create_by_name(meta[:publisher].titleize) unless meta[:publisher].nil?
      book = Book.create(:title => meta[:title].titleize, :author => author, :publisher => publisher, :isbn => meta[:isbn], :file_name => file_name, :file_size => File.stat(file_name).size)
      throw "Could not save book #{book.errors.inspect}" unless book.save
    end
    save_meta(book.id, fetch_online_metadata(book.id))
    book.reload
    new_file_name = "#{RAILS_ROOT}/public/ebooks/#{book.id}.epub"
    convert_ebook(file_name, new_file_name) unless new_file_name == file_name
    book.file_name = new_file_name
    book.file_size = File.stat(new_file_name).size
    book.save
    fetch_cover(book.id)
    set_ebook_metadata(book.id)
  end
  
  def self.get_ebook_metadata(file_name)
    meta = `ebook-meta "#{file_name}"`
    parse_meta(meta)
  end
  
  def self.set_ebook_metadata(id)
    book = Book.find(id)
    args = ""
    args += " -t \"#{book.title}\"" unless book.title.nil?
    args += " -a \"#{book.author.name}\"" unless book.author.nil?
    args += " -i \"#{book.isbn}\"" unless book.isbn.nil?
    args += " -l \"#{book.language}\"" unless book.language.nil?
    args += " -p \"#{book.publisher.name}\"" unless book.publisher.nil?
    args += " -s \"#{book.series.name}\"" unless book.series.nil?
    args += " --tags=\"#{book.tags.join(",")}\"" unless book.tags.empty?
    args += " --cover=\"#{RAILS_ROOT}/public/covers/#{book.isbn}.jpg\"" unless book.isbn.nil? or not File.exists?("#{RAILS_ROOT}/public/covers/#{book.isbn}.jpg")
    args += " -c \"SUMMARY:\n#{book.summary}\"" unless book.summary.nil?
    meta = `ebook-meta "#{book.file_name}" #{args}`
    parse_meta(meta)
  end
  
  def self.fetch_online_metadata(id)
    book = Book.find(id, :include => [:author, :publisher])
    return nil if book.nil?
    args = ""
    args += " -t \"#{book.title}\"" unless book.title.nil?
    args += " -a \"#{book.author.name}\"" unless book.author.nil?
    args += " -i \"#{book.isbn}\"" unless book.isbn.nil?
    args += " -m 1"
    meta = `fetch-ebook-metadata #{args}`
    parse_meta(meta)
  end
  
  def self.parse_meta(meta)
    regexs = [
      ['title', /Title[\W]*: (.*?)\n/],
      ['author', /Author\(s\)[\W]*: (.*?)\n/],
      ['publisher', /Publisher[\W]*: (.*?)\n/],
      ['summary', /Comments[\W]*: SUMMARY:\n(.*?)\n/],
      ['tags', /Tags[\W]*: (.*?)\n/],
      ['isbn', /ISBN[\W]*: (.*?)\n/],
      ['language', /Language[\W]*: (.*?)\n/],
      ['published', /Published[\W]*: (.*?)\n/]
    ]
    output = {}
    regexs.each do |regex|
      output.merge!({regex[0].to_sym => meta.scan(regex[1])[0][0]}) unless meta.scan(regex[1]).nil? or meta.scan(regex[1])[0].nil? or meta.scan(regex[1])[0][0].nil?
    end
    output[:isbn].gsub!(/-/, "") unless output[:isbn].nil?
    output[:title] = output[:title].titleize unless output[:title].nil?
    output[:author] = output[:author].titleize unless output[:author].nil?
    output[:publisher] = output[:publisher].titleize unless output[:publisher].nil?
    return output
  end
  
  def self.save_meta(id, meta)
    book = Book.find(id)
    return nil if book.nil?
    author = Author.find_or_create_by_name(meta[:author].titleize)
    publisher = Publisher.find_or_create_by_name(meta[:publisher].titleize)
    tags = []
    meta[:tags].split(", ").each do |tag|
      tags << Tag.find_or_create_by_name(tag)
    end unless meta[:tags].nil?
    book.author = author
    book.publisher = publisher
    book.tags << tags unless tags.empty?
    book.title = meta[:title].titleize
    book.summary = meta[:summary]
    book.language = meta[:language]
    book.isbn = meta[:isbn]
    book.save
  end
  
  def self.fetch_cover(id)
    book = Book.find(id, :include => [:author, :publisher])
    return false if book.isbn.nil?
    FileUtils.mkdir_p "#{RAILS_ROOT}/public/covers/"
    result = `cd public/covers && librarything "#{book.isbn}"`
    cover_file = result.scan(/Cover saved to file (.*)/)[0][0] unless result.scan(/Cover saved to file (.*)/).nil? or result.scan(/Cover saved to file (.*)/)[0].nil? or result.scan(/Cover saved to file (.*)/)[0][0].nil?
    return nil if cover_file.nil?
    book.cover_file_name = cover_file
    book.save
    return cover_file
  end
  
  def self.convert_ebook(old_file_name, new_file_name)
    result = `ebook-convert "#{old_file_name}" "#{new_file_name}"`
    return result
  end
end

