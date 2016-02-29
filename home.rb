require "sinatra"
require "sinatra/activerecord"
require "./models"
require "sinatra/flash"

set :database, "sqlite3:vent.db"
enable :sessions
set :sessions, true

get "/" do
  erb :index
end

get "/users" do
	@users = User.all
	erb :users
end

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

def current_user
  @current_user = User.find(session[:user_id])
end 

get "/posts" do 
  if session[:user_id] == nil
    redirect "/"
  end
	@posts = Post.all
  @ten_posts = Post.last(10)
	erb :posts
end 

post "/posts" do 
  Post.create(user_id: current_user.id, body: params[:body])
  redirect "/posts"
end

get "/logout" do
  session[:user_id] = nil
  redirect "/"
end

get "/users/:id" do 
  "Id: " + params[:id]
  @posts = Post.where(user_id: params[:id])
  @name = User.find(params[:id]).name
  @email = User.find(params[:id]).email  
  @password = User.find(params[:id]).password
  erb :users
end

get "/profile" do 
  @user = current_user
  if session[:user_id] = nil
    redirect "/"
  end
	erb :profile
end

post "/update" do
  @user = current_user
  user.update_attribute(:name, params[:name]) 
  user.update_attribute(:email, params[:email]) 
  user.update_attribute(:password, params[:password]) 
  redirect "/profile"
end

post "/delete" do
  @user = current_user
  user.destroy
  user_posts = Post.where(user_id: user.id)
  user_posts.each do |post|
    post.destroy
  end 
  flash[:delete] = "You have succesfully deleted your account"
  session[:user_id] = nil
  redirect "/"
end

get "/goback" do 
  @posts = Post.all
  erb :posts
end 


