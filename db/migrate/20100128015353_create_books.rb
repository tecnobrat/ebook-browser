class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.column :publisher_id,    :integer
      t.column :author_id,       :integer
      t.column :series_id,       :integer
      t.column :uuid,            :string, :limit => 36
      t.column :title,           :string
      t.column :isbn,            :bigint
      t.column :file_size,       :bigint
      t.column :file_name,       :string
      t.column :cover_file_name, :string
      t.column :language,        :string
      t.column :summary,         :text
      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
