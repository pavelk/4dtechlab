class Addpersondatatouser < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :website, :string
    add_column :users, :phone_office, :string
    add_column :users, :phone_mobile, :string
    add_column :users, :fax, :string
    add_column :users, :agency, :string
    add_column :users, :user_position, :string
    add_column :users, :country, :string
  end

  def self.down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :website
    remove_column :users, :phone_office
    remove_column :users, :phone_mobile
    remove_column :users, :fax
    remove_column :users, :agency
    remove_column :users, :user_position
    remove_column :users, :country
  end
end
