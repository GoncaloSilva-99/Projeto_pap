class ReportCommentsController < ApplicationController
  before_action :set_report_comment, only: %i[ show edit update destroy ]

  # GET /report_comments or /report_comments.json
  def index
    @report_comments = ReportComment.all
  end

  # GET /report_comments/1 or /report_comments/1.json
  def show
  end

  # GET /report_comments/new
  def new
    @report_comment = ReportComment.new
  end

  # GET /report_comments/1/edit
  def edit
  end

  # POST /report_comments or /report_comments.json
  def create
    @report_comment = ReportComment.new(report_comment_params)

    respond_to do |format|
      if @report_comment.save
        format.html { redirect_to @report_comment, notice: "Report comment was successfully created." }
        format.json { render :show, status: :created, location: @report_comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /report_comments/1 or /report_comments/1.json
  def update
    respond_to do |format|
      if @report_comment.update(report_comment_params)
        format.html { redirect_to @report_comment, notice: "Report comment was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @report_comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report_comments/1 or /report_comments/1.json
  def destroy
    @report_comment.destroy!

    respond_to do |format|
      format.html { redirect_to report_comments_path, notice: "Report comment was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report_comment
      @report_comment = ReportComment.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def report_comment_params
      params.expect(report_comment: [ :post_comment_id, :content, :resolved ])
    end
end
