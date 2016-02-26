require "sinatra"
require "sinatra/activerecord"
# require "./models"

# set :database, "sqlite3:vent.db"

# get "/create" do
# 	User.create(name: "Shraddha",email: "spatelrb@gmail.com")

# 	"New user created"
# end

# get "/all" do
# 	@users = User.all
# 	erb :index
# end

# get "/newpost" do 
# 	# user = User.first
# 	Post.create(body: "The bus ran late and I hate my life",user_id: "user.id")

# 	"New post created"
# end

get "/home" do 
	erb :index
end


