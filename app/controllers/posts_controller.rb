class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /posts or /posts.json
  def index
    @page = params[:page]&.to_i || 1
    @posts = current_user.feed_posts(page: @page, per_page: 25)
    @posts.each { |post| post.mark_as_viewed_by(current_user) }
    @suggested_users = current_user.suggested_users_to_follow(limit: 6)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post.mark_as_viewed_by(current_user)
    @comments = @post.comments.newest_first.includes(:user)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove("post_#{@post.id}")
      end
      format.html notice: 'Post eliminado com sucesso!' 
    end
  end

  # POST /posts or /posts.json
  
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend(
          "posts_list",
          partial: "posts/post",
          locals: { post: @post }
          )
        end
        format.html { redirect_to root_path, notice: 'Post criado com sucesso.' }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
          "post_form",
          partial: "posts/form",
          locals: { post: @post }
          ), status: :unprocessable_entity
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if @post.update(post_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
          "post_#{@post.id}",
          partial: "posts/post",
          locals: { post: @post }
          )
        end
        format.html { redirect_to @post, notice: 'Post atualizado com sucesso.' }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
          "post_form_#{@post.id}",
          partial: "posts/edit_form",
          locals: { post: @post }
          ), status: :unprocessable_entity
        end
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove("post_#{@post.id}")
      end
      format.html { redirect_to root_path, notice: 'Post eliminado.' }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :content, :likes_count, :comments_count, :views_count, images: [])
    end
end
