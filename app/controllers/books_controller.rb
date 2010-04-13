class BooksController < ApplicationController
  def list
    @updated_at = Book.find(:first, :order => 'updated_at desc').updated_at
    @books = Book.find(:all, :include => [:author, :publisher], :order => 'title asc')
    render :partial => 'list', :layout => 'application'
  end
  
  def by_author
    @updated_at = Book.find(:first, :order => 'updated_at desc').updated_at
    @books = Book.find(:all, :include => [:author, :publisher], :conditions => ["author_id = ?", params[:id]], :order => 'title asc')
    render :partial => 'list', :layout => 'application'
  end

  def by_publisher
    @updated_at = Book.find(:first, :order => 'updated_at desc').updated_at
    @books = Book.find(:all, :include => [:author, :publisher], :conditions => ["publisher_id = ?", params[:id]], :order => 'title asc')
    render :partial => 'list', :layout => 'application'
  end

  def by_series
    @updated_at = Book.find(:first, :order => 'updated_at desc').updated_at
    @books = Book.find(:all, :include => [:author, :publisher], :conditions => ["series_id = ?", params[:id]], :order => 'title asc')
    render :partial => 'list', :layout => 'application'
  end
  
  def by_tag
    @updated_at = Book.find(:first, :order => 'updated_at desc').updated_at
    @books = Book.find(:all, :include => [:author, :publisher, :tags], :conditions => ["books_tags.tag_id = ?", params[:id]], :order => 'title asc')
    render :partial => 'list', :layout => 'application'
  end
end
