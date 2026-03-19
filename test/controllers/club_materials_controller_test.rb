require "test_helper"

class ClubMaterialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club_material = club_materials(:one)
  end

  test "should get index" do
    get club_materials_url
    assert_response :success
  end

  test "should get new" do
    get new_club_material_url
    assert_response :success
  end

  test "should create club_material" do
    assert_difference("ClubMaterial.count") do
      post club_materials_url, params: { club_material: { club_profile_id: @club_material.club_profile_id, description: @club_material.description, name: @club_material.name, quantity: @club_material.quantity } }
    end

    assert_redirected_to club_material_url(ClubMaterial.last)
  end

  test "should show club_material" do
    get club_material_url(@club_material)
    assert_response :success
  end

  test "should get edit" do
    get edit_club_material_url(@club_material)
    assert_response :success
  end

  test "should update club_material" do
    patch club_material_url(@club_material), params: { club_material: { club_profile_id: @club_material.club_profile_id, description: @club_material.description, name: @club_material.name, quantity: @club_material.quantity } }
    assert_redirected_to club_material_url(@club_material)
  end

  test "should destroy club_material" do
    assert_difference("ClubMaterial.count", -1) do
      delete club_material_url(@club_material)
    end

    assert_redirected_to club_materials_url
  end
end
