  @publishers.each do |publisher|
    xml.entry do
      xml.title publisher.name
      xml.updated @updated_at.xmlschema
      xml.id "urn:uuid:#{publisher.uuid}"
      xml.link "type" => "application/atom+xml", "href" => url_for(:controller => "books", :action => "by_publisher", :id => publisher, :format => 'xml')

      xml.content "type" => "text" do
        xml.cdata! "#{publisher.books.size} books"
      end
    end
  end