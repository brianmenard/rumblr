class UsersController < ApplicationController
    
    def index
        @users = User.all
    end
    
    def show
        @user = User.find(params[:id])
        @posts = @user.posts
    end
    
    def following
       @following = current_user.following 
    end
    
    def followers
       @followers = current_user.followers 
    end
    
end
