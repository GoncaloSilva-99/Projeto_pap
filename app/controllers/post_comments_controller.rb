class PostCommentsController < ApplicationController
  before_action :set_post_comment, only: %i[ show edit update destroy ]
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
    @comment = @post.post_comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append(
            "comments_list_#{@post.id}",
            partial: "comments/comment",
            locals: { comment: @comment }
          ),
          turbo_stream.replace(
            "comment_form_#{@post.id}",
            partial: "comments/form",
            locals: { post: @post, comment: PostComment.new }
          ),
          turbo_stream.replace(
            "comments_count_#{@post.id}",
            partial: "posts/comments_count",
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
    # Use callbacks to share common setup or constraints between actions.
    def set_post_comment
      @post_comment = PostComment.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def post_comment_params
      params.expect(post_comment: [ :user_id, :post_id, :content ])
    end
end
