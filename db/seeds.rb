# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

author = Author.create(:name => "Bob Barker")
publisher = Publisher.create(:name => "Bob Barker's Publishing")
Book.create(:title => "Bob Barker's Girlfriends", :author => author, :publisher => publisher)