class TagsController < ApplicationController
  def list
    @updated_at = Book.find(:first, :order => 'updated_at desc').updated_at
    @tags = Tag.find(:all, :include => [:books], :order => 'name asc', :conditions => "books.id > 0")
  end
end
