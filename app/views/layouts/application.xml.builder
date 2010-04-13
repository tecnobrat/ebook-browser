xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title "eBook Library"
  xml.updated @updated_at.xmlschema
  xml.id "urn:ebooks:tecnobrat"
  xml.link "rel" => "search", "title" => "Search", "type" => "application/atom+xml", "href" => "/books/search?terms={searchTerms}"
  xml.author do
    xml.name "Brian Stolz"
    xml.uri "http://www.tecnobrat.com/"
    xml.email "brian@tecnobrat.com"
  end
  xml.subtitle "Online catalog of eBooks"
  xml << yield
end