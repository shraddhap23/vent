class CreateProfileTable < ActiveRecord::Migration
  def change
  	create_table :profiles do |table|
  		table.string :name
  		table.string :birthday
  		table.string :location
  		table.string :email
  		table.integer :user_id #foreign key taken from users table
  	end
  end
end