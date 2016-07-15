class PostsController < ApplicationController
  def index
    @posts = Post.all.order('created_at DESC') # move to model
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @user = User.find_by_id(session[:user_id])

    if @post.save

      # associates a post to a user by using the .create method, which automatically sets the @user.id

      #based on our model, looks like the only thing connecting user to post is a comment....
      #Post model => has_many :users, through: :comments
      @comment = Comment.create(user: @user, post: @post, content: @post.content)

      #@post= @user.posts.create(title: params[:title], content: params[:content])


      redirect_to posts_path
    else
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post # can infer into the @post instance and know to go to the show page, see create action.
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
