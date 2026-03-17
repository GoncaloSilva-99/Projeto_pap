class ReportPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:create]

  def create
    @report_post = @post.report_posts.build(report_post_params)
    @report_post.user = current_user
    @report_post.resolved = false

    if @report_post.save
      flash[:notice] = "Publicação reportada com sucesso"
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("flash", partial: "shared/flash")
          ]
        end
        format.html { redirect_back(fallback_location: root_path, notice: "Publicação reportada com sucesso") }
      end
    else
      flash[:alert] = @report_post.errors.full_messages.join(", ")
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash")
        end
        format.html { redirect_back(fallback_location: root_path, alert: @report_post.errors.full_messages.join(", ")) }
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def report_post_params
    params.require(:report_post).permit(:content)
  end
end 