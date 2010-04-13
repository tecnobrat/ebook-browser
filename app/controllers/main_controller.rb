class MainController < ApplicationController
  def index
  @updated_at = Book.find(:first, :order => 'updated_at desc').updated_at
    @data = [
      {:name => 'Title', :action => :list, :controller => :books, :uuid => UUIDTools::UUID.parse_raw("By Title")},
      {:name => 'Author', :action => :list, :controller => :authors, :uuid => UUIDTools::UUID.parse_raw("By Author")},
      {:name => 'Tag', :action => :list, :controller => :tags, :uuid => UUIDTools::UUID.parse_raw("By Tag")}
    ]
    respond_to do |format|
      format.xml  { render }
      format.html  { render }
    end
  end
end
