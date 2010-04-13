  @tags.each do |tag|
    xml.entry do
      xml.title tag.name
      xml.updated @updated_at.xmlschema
      xml.id "urn:uuid:#{tag.uuid}"
      xml.link "type" => "application/atom+xml", "href" => url_for(:controller => "books", :action => "by_tag", :id => tag, :format => 'xml')

      xml.content "type" => "text" do
        xml.cdata! "#{tag.books.size} books"
      end
    end
  end