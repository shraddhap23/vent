class CreateUsersTable < ActiveRecord::Migration
  def change
  	create_table :users do |table|
  		# table.integer :id
  		table.string :name
  		table.string :email
  	end
  end
end


