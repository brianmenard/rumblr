class UsersController < ApplicationController
    
    def index
        @users = User.all
    end
    
    def show
        @user = User.find(params[:id])
        @posts = @user.posts
        #sort @posts by date
        @posts = @posts.sort_by { |a| [ a.created_at ] }.reverse!
    end
    
    def following
       @following = current_user.following 
    end
    
    def followers
       @followers = current_user.followers 
    end
    
    def discover
        @top_blogs = User.all.sort_by { |a| [a.posts.count] }
    end
    
end
