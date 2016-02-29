require "sinatra"
require "sinatra/activerecord"
require "./models"
require "sinatra/flash"

set :database, "sqlite3:vent.db"
set :sessions, true

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
  flash[:notice] = "New user has been created"
  puts "my params are" + params.inspect
  	redirect "/posts"
end

get "/login" do
  erb :login
end 

get "/users/:id" do 
  "Id: " + params[:id]
end

post "/login" do
  @user = User.where(name: params[:name]).first
  if @user && @user.password == params[:password]
  	session[:user_id] = @user.id
		redirect "/posts"
  else
    flash[:alert] = "Combination of email and password does not match"
    redirect "/login"
  end 
end

get "/posts" do 
	@posts = Post.all
	erb :posts
end 

post "/posts" do 
  Post.create(user_id: current_user.id, body: params[:body])
  redirect "/posts"
end

get "/profile" do 
  if session[:user_id] == nil
    redirect "/"
  end
	erb :profile
end

post "/profile" do
  user = current_user

  user.update_attribute


post "/acct" do
  user = current_user
  user.update_attribute(:name, params[:name]) if params[:name] != ""
  user.update_attribute(:birthday, params[:birthday]) if params[:birthday] != ""
  user.update_attribute(:location, params[:location]) if params[:location] != ""
  user.update_attribute(:email, params[:email]) if params[:email] != ""
  redirect "/profile"
end

post "/delete" do
  user = current_user
  user.destroy
  user_posts = Post.where(user_id: user.id)
  user_posts.each do |post|
    post.destroy
  end 
  flash[:delete] = "You have succesfully deleted your account"
  session[:user_id] = nil
  redirect "/"
  end
end

