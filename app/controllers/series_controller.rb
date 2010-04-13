class SeriesController < ApplicationController
  def list
    @updated_at = Book.find(:first, :order => 'updated_at desc').updated_at
    @series = Series.find(:all, :include => [:books], :order => 'name asc', :conditions => "books.id > 0")
  end
end
