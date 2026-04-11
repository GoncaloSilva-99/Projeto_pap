class CoachProfilesController < ApplicationController
  before_action :set_coach_profile, only: %i[ show edit update destroy ]

  def remove_from_club
    @sport = params[:sport]
    @coach_profile = CoachProfile.find(params[:id])
    @coach_profile.update(club_profile_id: nil)
    respond_to do |format|
      format.html { redirect_to club_teams_dashboard_path(sport: @sport), notice: "Treinador removido do clube com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # GET /coach_profiles or /coach_profiles.json
  def index
    @coach_profiles = CoachProfile.all
  end

  # GET /coach_profiles/1 or /coach_profiles/1.json
  def show
    @page = params[:page]&.to_i || 1
    posts_per_page = 25
    
    @posts = Post.where(user_id: @coach_profile.user.id).recent.offset((@page - 1) * posts_per_page)

    @has_more_posts = @posts.length == posts_per_page

    @post_comments = PostComment.where(post_id: @post)
    @num_post_comments = @post_comments.count
  end

  # GET /coach_profiles/new
  def new
    @coach_profile = CoachProfile.new
  end

  # GET /coach_profiles/1/edit
  def edit
    @coach_profile.build_user if @coach_profile.user.nil?
  end

  # POST /coach_profiles or /coach_profiles.json
  def create
    @coach_profile = CoachProfile.new(coach_profile_params)

    respond_to do |format|
      if @coach_profile.save
        format.html { redirect_to @coach_profile, notice: "Conta de Treinador criada com sucesso!" }
        format.json { render :show, status: :created, location: @coach_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @coach_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coach_profiles/1 or /coach_profiles/1.json
  def update
    # Handle image removal
    @coach_profile.profile_picture.purge if params[:coach_profile][:remove_profile_picture] == '1'
    @coach_profile.banner_picture.purge if params[:coach_profile][:remove_banner_picture] == '1'

    # Extract user-related fields (email / password) so we can update the Devise user separately.
    profile_params = coach_profile_params.dup
    user_attrs = profile_params.delete(:user_attributes)

    # Clean bio - remove indentation spaces but keep user-inserted line breaks
    if profile_params[:bio].present?
      profile_params[:bio] = profile_params[:bio].strip.lines.map(&:strip).join("\n")
    end

    user_update_success = true
    account_details_changed = false

      if user_attrs.present?
        user = @coach_profile.user
        email_being_changed = user_attrs[:email].present? && user_attrs[:email] != user.email
        password_being_changed = user_attrs[:password].present?

        if (email_being_changed || password_being_changed) && user_attrs[:current_password].blank?
          @coach_profile.errors.add(:base, "É necessário introduzir a palavra-passe atual para alterar email ou palavra-passe.")
          user_update_success = false
        elsif !user.valid_password?(user_attrs[:current_password].to_s)
          @coach_profile.errors.add(:base, "A palavra-passe atual está incorreta.")
          user_update_success = false
        else
          if email_being_changed
            user.skip_reconfirmation!
            user.update_column(:unconfirmed_email, user_attrs[:email])
            token, encoded_token = Devise.token_generator.generate(User, :confirmation_token)
            user.update_columns(
              confirmation_token: encoded_token,
              confirmation_sent_at: Time.now.utc
            )
            UserMailer.reconfirmation_email(user, token).deliver_now
          end
          if password_being_changed
            user.password = user_attrs[:password]
            user.password_confirmation = user_attrs[:password_confirmation]
          end
          user_update_success = user.save
          account_details_changed = email_being_changed || password_being_changed
        end

        if user.errors.any?
          user.errors.full_messages.each { |msg| @coach_profile.errors.add(:base, msg) }
        end
      end

    respond_to do |format|
      if user_update_success && @coach_profile.update(profile_params)
        if account_details_changed
          sign_out(current_user) if current_user
          format.html { redirect_to new_user_session_path, notice: "Dados de login alterados. Por favor, entre novamente.", status: :see_other }
        else
          format.html { redirect_to @coach_profile, notice: "Conta de Treinador atualizada com sucesso!", status: :see_other }
        end
        format.json { render :show, status: :ok, location: @coach_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coach_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coach_profiles/1 or /coach_profiles/1.json
  def destroy
    @coach_profile.destroy!

    respond_to do |format|
      format.html { redirect_to coach_profiles_path, notice: "Conta de treinador apagada com sucesso!", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coach_profile
      @coach_profile = CoachProfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def coach_profile_params
      permitted_params = [:user_id, :name, :status, :approved_by, :bio, :banner_picture, :profile_picture, :foundation_date]

      if action_name == 'update'
        permitted_params << { user_attributes: [:email, :email_confirmation, :current_password, :password, :password_confirmation] }
      end

      params.require(:coach_profile).permit(*permitted_params)
    end
end