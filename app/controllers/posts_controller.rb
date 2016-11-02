class PostsController < ApplicationController
    
    def index
        if !current_user
            redirect_to new_user_session_path
        end
       @posts = Post.all 
    end
    
    def feed
        if !current_user
            redirect_to new_user_session_path
        end
       @posts = []
       @following = current_user.following
       
       #loop to get all posts from each user (loop by @following),
       #adding each users posts to @posts
       
       @following.each do |user|
          @posts =  @posts + user.posts 
       end
       
       #sort @posts by date
       @posts = @posts.sort_by { |a| [ a.created_at ] }
    end
    
    def new 
        if !current_user
            redirect_to new_user_session_path
        end
        @post = Post.new
    end
    
    def create
       @post = Post.new(post_params) 
       @post.user = current_user
       if @post.save
          redirect_to @post 
       end
    end
    
    def show
       @post = Post.find(params[:id]) 
    end
   
   
private
   def post_params
    params.require(:post).permit(:title, :body)
   end
    
end
