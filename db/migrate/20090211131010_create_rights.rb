class CreateRights < ActiveRecord::Migration
  def self.up
    create_table :rights do |t|
      t.string :name
      t.string :controller
      t.string :action
    end
    create_table :rights_roles, :id => false do |t| 
      t.integer :right_id
      t.integer :role_id
    end 
    #add_index ":rights_roles", ["right_id"], :name => "index_rights_roles_on_right_id"
    #add_index ":rights_roles", ["role_id"], :name => "index_roles_roles_on_role_id"
  end

  def self.down
    drop_table :rights
    drop_table :rights_roles
  end
end
