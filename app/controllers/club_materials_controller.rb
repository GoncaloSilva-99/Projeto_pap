class ClubMaterialsController < ApplicationController
  before_action :set_club_material, only: %i[ show edit update destroy ]

  # GET /club_materials or /club_materials.json
  def index
    @club_materials = ClubMaterial.all
  end

  # GET /club_materials/1 or /club_materials/1.json
  def show
  end

  # GET /club_materials/new
  def new
    @club_material = ClubMaterial.new
  end

  # GET /club_materials/1/edit
  def edit
  end

  # POST /club_materials or /club_materials.json
  def create
    current_club = current_user.club? ? 
      current_user.club_profile : 
      current_user.board_profile.club_profile

    @club_material = current_club.club_materials.build(club_material_params)

    if @club_material.save
      redirect_to club_equipment_dashboard_path, notice: "Material adicionado."
    else
      redirect_to club_equipment_dashboard_path, alert: @club_material.errors.full_messages.join(", ")
    end
  end

  def update
    if params[:club_material][:remove_image] == '1'
      @club_material.image.purge
    end
    if @club_material.update(club_material_params)
      redirect_to club_equipment_dashboard_path, notice: "Material atualizado."
    else
      redirect_to club_equipment_dashboard_path, alert: @club_material.errors.full_messages.join(", ")
    end
  end

  def destroy
    @club_material.destroy!
    redirect_to club_equipment_dashboard_path, notice: "Material apagado."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club_material
      @club_material = ClubMaterial.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def club_material_params
      params.require(:club_material).permit(:name, :quantity, :description, :sport, :image, :remove_image)
    end
end
  