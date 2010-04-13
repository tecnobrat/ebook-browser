class AuthorsController < ApplicationController
  def list
    @updated_at = Book.find(:first, :order => 'updated_at desc').updated_at
    @authors = Author.find(:all, :include => [:books], :order => 'name asc', :conditions => "books.id > 0")
  end
end
