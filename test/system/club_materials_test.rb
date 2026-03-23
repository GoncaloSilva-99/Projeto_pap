require "application_system_test_case"

class ClubMaterialsTest < ApplicationSystemTestCase
  setup do
    @club_material = club_materials(:one)
  end

  test "visiting the index" do
    visit club_materials_url
    assert_selector "h1", text: "Club materials"
  end

  test "should create club material" do
    visit club_materials_url
    click_on "New club material"

    fill_in "Club profile", with: @club_material.club_profile_id
    fill_in "Description", with: @club_material.description
    fill_in "Name", with: @club_material.name
    fill_in "Quantity", with: @club_material.quantity
    click_on "Create Club material"

    assert_text "Club material was successfully created"
    click_on "Back"
  end

  test "should update Club material" do
    visit club_material_url(@club_material)
    click_on "Edit this club material", match: :first

    fill_in "Club profile", with: @club_material.club_profile_id
    fill_in "Description", with: @club_material.description
    fill_in "Name", with: @club_material.name
    fill_in "Quantity", with: @club_material.quantity
    click_on "Update Club material"

    assert_text "Club material was successfully updated"
    click_on "Back"
  end

  test "should destroy Club material" do
    visit club_material_url(@club_material)
    accept_confirm { click_on "Destroy this club material", match: :first }

    assert_text "Club material was successfully destroyed"
  end
end
