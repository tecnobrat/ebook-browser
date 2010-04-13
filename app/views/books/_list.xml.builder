  @books.each do |book|
    xml.entry do
      xml.title book.title
      xml.updated book.updated_at.xmlschema
      xml.id "urn:uuid:#{book.uuid}"
      xml.author do
        xml.name book.author.name
      end
      xml.link "type" => "application/epub+zip", "href" => "/ebooks/#{book.id}.epub"
      xml.link "rel" => "x-stanza-cover-image", "type" => "image/jpeg", "href" => "/covers/#{book.isbn}.jpg" unless book.isbn.nil? or not File.exists?("#{RAILS_ROOT}/public/covers/#{book.isbn}.jpg")
      xml.link "rel" => "x-stanza-cover-image-thumbnail", "type" => "image/jpeg", "href" => "/covers/#{book.isbn}.jpg" unless book.isbn.nil? or not File.exists?("#{RAILS_ROOT}/public/covers/#{book.isbn}.jpg")
      xml.content "type" => "xhtml" do
        xml.div "xmlns" => "http://www.w3.org/1999/xhtml", "style" => "text-align: center" do
          xml.cdata! "TAGS: #{book.tags.collect { |tag| tag.name}.join(", ")}<br />SUMMARY: #{book.summary}"
        end
      end
    end
  end