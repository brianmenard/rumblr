class PostsController < ApplicationController
    
    def index
        if !current_user
            redirect_to new_user_session_path
        end
       @posts = Post.all.sort_by { |a| [ a.created_at ] }.reverse!
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
       
       #add users own posts
       @posts = @posts + current_user.posts
       
       #sort @posts by date
       @posts = @posts.sort_by { |a| [ a.created_at ] }.reverse!
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
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
    end
    
    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])
        @post.update(post_params)
        redirect_to post_path(@post)
    end
    
    def reblog
        @post = Post.find(params[:id]) 
        @new_post = Post.new
        @new_post.title = @post.title
        @new_post.body = @post.body
        @new_post.user = current_user
        @new_post.reblogged_from = @post.user.id
        if @new_post.save
          redirect_to feed_path 
        end
    end
    
   # def post_reblog
#        @post = Post.new(post_params) 
 #       @post.user = current_user
  #      @post.reblogged_from = params[:reblogged_from]
   #     if @post.save
    #      redirect_to feed_path 
    #    end
    #end
   
   
private
   def post_params
    params.require(:post).permit(:title, :body)
   end
    
end
