class PostSavesController < ApplicationController
  before_action :set_post, only: %i[ create destroy ]

  def create
    @save = @post.post_saves.build(user: current_user)
    flash.now[:notice] = "Post guardado com sucesso!"
    if @save.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              "save_section_#{@post.id}",
              partial: "posts/save_section",
              locals: { post: @post }
            ),
            turbo_stream.update(
              "saved_posts_list",
              partial: "posts/saved_posts_list"
            ),
            turbo_stream.update(
              "saved_count_#{current_user.id}",
              partial: "posts/saved_count"
            ),
            turbo_stream.replace("flash", partial: "shared/flash")
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
    @save = @post.post_saves.find_by(user: current_user)
    flash.now[:notice] = "Post removido dos guardados!"
    if @save&.destroy
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              "save_section_#{@post.id}",
              partial: "posts/save_section",
              locals: { post: @post }
            ),
            turbo_stream.update(
              "saved_posts_list",
              partial: "posts/saved_posts_list"
            ),
            turbo_stream.update(
              "saved_count_#{current_user.id}",
              partial: "posts/saved_count"
            ),
            turbo_stream.replace("flash", partial: "shared/flash")
          ]
        end
        format.html { redirect_to root_path, notice: "Post removido dos guardados" }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, alert: "Erro ao remover" }
      end
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
