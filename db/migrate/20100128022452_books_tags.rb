class BooksTags < ActiveRecord::Migration
  def self.up
    create_table "books_tags", :id => false do |t|
      t.column :book_id,  :integer
      t.column :tag_id,   :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :books_tags
  end
end
