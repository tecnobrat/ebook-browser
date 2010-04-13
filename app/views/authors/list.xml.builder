  @authors.each do |author|
    xml.entry do
      xml.title author.name
      xml.updated @updated_at.xmlschema
      xml.id "urn:uuid:#{author.uuid}"
      xml.link "type" => "application/atom+xml", "href" => url_for(:controller => "books", :action => "by_author", :id => author, :format => 'xml')

      xml.content "type" => "text" do
        xml.cdata! "#{author.books.size} books"
      end
    end
  end