class ClubProfilesController < ApplicationController
  before_action :set_club_profile, only: %i[ show edit update destroy ]

  # GET /club_profiles or /club_profiles.json
  def index
    @club_profiles = ClubProfile.all
  end

  # GET /club_profiles/1 or /club_profiles/1.json
  def show
      @page = params[:page]&.to_i || 1
      posts_per_page = 25
      
      @posts = Post.where(user_id: @club_profile.user.id).recent.offset((@page - 1) * posts_per_page)

      @has_more_posts = @posts.length == posts_per_page

      @post_comments = PostComment.where(post_id: @post)
      @num_post_comments = @post_comments.count
  end

  # GET /club_profiles/new
  def new
    @club_profile = ClubProfile.new
  end

  # GET /club_profiles/1/edit
  def edit
    @club_profile.build_user if @club_profile.user.nil?
  end

  # POST /club_profiles or /club_profiles.json
  def create
    @club_profile = ClubProfile.new(club_profile_params)

    respond_to do |format|
      if @club_profile.save
        format.html { redirect_to @club_profile, notice: "Perfil criado com sucesso!" }
        format.json { render :show, status: :created, location: @club_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @club_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /club_profiles/1 or /club_profiles/1.json
  def update
    # Handle image removal
    @club_profile.profile_picture.purge if params[:club_profile][:remove_profile_picture] == '1'
    @club_profile.banner_picture.purge if params[:club_profile][:remove_banner_picture] == '1'

    # Extract user-related fields (email / password) so we can update the Devise user separately.
    profile_params = club_profile_params.dup
    user_attrs = profile_params.delete(:user_attributes)

    # Clean bio - remove indentation spaces but keep user-inserted line breaks
    if profile_params[:bio].present?
      profile_params[:bio] = profile_params[:bio].strip.lines.map(&:strip).join("\n")
    end

    user_update_success = true
    account_details_changed = false

    if user_attrs.present?
      user_attrs = user_attrs.to_h
      # Keep confirmation fields around so validations can run even if blank.
      user_attrs = user_attrs.reject do |k, v|
        v.blank? && !%w[email_confirmation password_confirmation].include?(k.to_s)
      end

      if user_attrs.present? && @club_profile.user.present?
        user = @club_profile.user

        # Check if account details should trigger logout.
        account_details_changed = user_attrs[:email].present? && user_attrs[:email] != user.email
        account_details_changed ||= user_attrs[:password].present?

        # If changing email or password, require current password for security.
        email_being_changed = user_attrs[:email].present? && user_attrs[:email] != user.email
        password_being_changed = user_attrs[:password].present?

        if (email_being_changed || password_being_changed) && user_attrs[:current_password].blank?
          @club_profile.errors.add(:base, "É necessário introduzir a palavra-passe atual para alterar email ou palavra-passe.")
          user_update_success = false
        elsif user_attrs[:current_password].present?
          user_update_success = user.update_with_password(user_attrs)
        else
          user_update_success = user.update_without_password(user_attrs.except(:current_password))
        end

        # Surface Devise errors in the form
        if user.errors.any?
          user.errors.full_messages.each { |msg| @club_profile.errors.add(:base, msg) }
        end
      end
    end

    respond_to do |format|
      if @club_profile.update(profile_params) && user_update_success
        if account_details_changed
          sign_out(current_user) if current_user
          format.html { redirect_to new_user_session_path, notice: "Dados de login alterados. Por favor, entre novamente.", status: :see_other }
        else
          format.html { redirect_to @club_profile, notice: "Conta de clube atualizada com sucesso.", status: :see_other }
        end
        format.json { render :show, status: :ok, location: @club_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @club_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /club_profiles/1 or /club_profiles/1.json
  def destroy
    @club_profile.destroy!

    respond_to do |format|
      format.html { redirect_to club_profiles_path, notice: "Perfil apagado com sucesso!", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club_profile
      @club_profile = ClubProfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def club_profile_params
      permitted_params = [:user_id, :name, :status, :approved_by, :bio, :banner_picture, :profile_picture, :foundation_date, :status]

      if action_name == 'update'
        permitted_params << { user_attributes: [:email, :email_confirmation, :current_password, :password, :password_confirmation] }
      end

      params.require(:club_profile).permit(*permitted_params)
    end
end