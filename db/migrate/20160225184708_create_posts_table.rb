class CreatePostsTable < ActiveRecord::Migration
  def change
  	create_table :posts do |table|
  		table.string :body
  		table.integer :user_id #foreign key taken from users table
  	end
  end
end
