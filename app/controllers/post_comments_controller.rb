class PostCommentsController < ApplicationController
  before_action :set_post, only: [:create]
  before_action :authenticate_user!

  # GET /post_comments or /post_comments.json
  def index
    @post_comments = PostComment.all
  end

  # GET /post_comments/1 or /post_comments/1.json
  def show
  end

  # GET /post_comments/new
  def new
    @post_comment = PostComment.new
  end

  # GET /post_comments/1/edit
  def edit
  end

  # POST /post_comments or /post_comments.json
  def create
    @comment = @post.post_comments.build(post_comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append(
            "comments_list_#{@post.id}",
            partial: "post_comments/post_comment",
            locals: { comment: @comment }
          ),
          turbo_stream.replace(
            "comment_form_#{@post.id}",
            partial: "post_comments/form",
            locals: { post: @post, comment: PostComment.new }
          ),
          turbo_stream.replace(
            "comments_count_#{@post.id}",
            partial: "posts/comments_count",
            locals: { post: @post }
          ),
          turbo_stream.replace(
            "comments_count_on_#{@post.id}", 
            partial: "posts/comments_count_on", 
            locals: { post: @post }
          )
          ]
        end
        format.html { redirect_to post_path(@post) }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "comment_form_#{@post.id}",
            partial: "comments/form",
            locals: { post: @post, comment: @comment }
          ), status: :unprocessable_entity
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end


  private

    def set_post
      @post = Post.find(params[:post_id])
    end


    # Only allow a list of trusted parameters through.
    def post_comment_params
      params.expect(post_comment: [ :user_id, :post_id, :content ])
    end
end
