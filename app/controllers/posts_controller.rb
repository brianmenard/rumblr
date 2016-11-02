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
       @posts = Post.all 
       @following = current_user.following
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
