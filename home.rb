require "sinatra"
require "sinatra/activerecord"
require "./models"

set :database, "sqlite3:vent.db"

get "/" do
  erb :index
end

get "/users" do
	@users = User.all
	erb :users
end

# get "/newpost" do 
# 	# user = User.first
# 	Post.create(body: "The bus ran late and I hate my life",user_id: "user.id")

# 	"New post created"
# end

get "/signup" do
  erb :signup
end

post "/signup" do
  puts params.inspect
  User.create(name: params[:name], email: params[:email], password: params[:password])
  # this is where we put the flash message 
  puts "my params are" + params.inspect
  	redirect "/profile"
end

get "/login" do
  erb :login
end 

get "/users/:id" do 
  "Id: " + params[:id]
end

post "/login" do
  @user = User.where(name: params[:name]).first
  if @user.password == params[:password]
		redirect "/profile"
  else
    redirect "/login"# flash message here to say combination is not ok 
  end 
end

get "/profile" do 
	erb :profile
end

get "/posts" do 
	erb :posts
end 

# post "/post" do
# end

