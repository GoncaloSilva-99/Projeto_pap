class PostsController < ApplicationController
  before_action :set_post, only: %i[ destroy ]
  before_action :authenticate_user!

  # GET /posts or /posts.json
  def index
    @page = params[:page]&.to_i || 1
    @posts = current_user.feed_posts(page: @page, per_page: 25)
    @posts.each { |post| post.mark_as_viewed_by(current_user) }
    @suggested_users = current_user.suggested_users_to_follow(limit: 6)
  end


  # GET /posts/new
  def new
    @post = Post.new
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
        format.html { redirect_back fallback_location: root_path, notice: 'Post criado com sucesso.' }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
          "post_form",
          partial: "posts/form",
          locals: { post: @post }
          ), status: :unprocessable_entity
          flash.now[:alert] = @post.errors.full_messages.to_sentence(words_connector: ", ", two_words_connector: "e", last_word_connector: "e")
          render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash")
        end
        format.html { redirect_back fallback_location: root_path, alert: @post.errors.full_messages.to_sentence }
      end
    end
  end




  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    flash.now[:notice] = "Post eliminado com sucesso!"
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove("post_#{@post.id}"),
          turbo_stream.replace("flash", partial: "shared/flash")
        ]
      end
      format.html {redirect_back fallback_location: root_path, notice: 'Post eliminado com sucesso!' }
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
