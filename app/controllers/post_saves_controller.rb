class PostSavesController < ApplicationController
  before_action :set_post, only: %i[ create destroy ]

  def create
    @save = @post.post_saves.build(user: current_user)

    if @save.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              "save_section_#{@post.id}",
              partial: "posts/save_section",
              locals: { post: @post }
            ),
            turbo_stream.replace(
              "save_section_modal_#{@post.id}",
              partial: "posts/save_section_modal",
              locals: { post: @post }
            )
          ]
        end
        format.html { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path }
      end
    end
  end

  # DELETE /post_saves/1 or /post_saves/1.json
  def destroy
    @post_safe.destroy!

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Post safe was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:post_id])
    end



    # Only allow a list of trusted parameters through.
    def post_saves_params
      params.permit(:user_id, :post_id)
    end
end
