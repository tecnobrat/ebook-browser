class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.column :name, :string
      t.column :uuid, :string, :limit => 36
      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
