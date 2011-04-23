class AddTableIndex < ActiveRecord::Migration
  def self.up
    add_index :departments, :name, :unique => true
    add_index :user_docs, :user_id, :unique => true
    add_index :user_docs, :doc_file_name, :unique => true
  end

  def self.down
  end
end
