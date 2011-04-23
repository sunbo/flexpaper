class AddUsersColumn < ActiveRecord::Migration
  def self.up
    add_column :users, :sex,     :string
    add_column :users, :department_id,   :integer
  end
:department_id
  def self.down
    remove_column :users, :sex
    remove_column :users, :department_id
  end
end
