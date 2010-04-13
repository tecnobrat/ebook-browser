  @data.each do |data|
    xml.entry do
      xml.title "By #{data[:name]}"
      xml.updated @updated_at.xmlschema
      xml.link "type" => "application/atom+xml", "href" => url_for(:controller => data[:controller], :action => data[:action], :format => 'xml')
      xml.content "Books sorted by #{data[:name]}", "type" => "text"
      xml.id "urn:uuid:#{data[:uuid]}"
    end
  end