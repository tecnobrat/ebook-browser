  @series.each do |series|
    xml.entry do
      xml.title series.name
      xml.updated @updated_at.xmlschema
      xml.id "urn:uuid:#{series.uuid}"
      xml.link "type" => "application/atom+xml", "href" => url_for(:controller => "books", :action => "by_series", :id => series, :format => 'xml')

      xml.content "type" => "text" do
        xml.cdata! "#{series.books.size} books"
      end
    end
  end