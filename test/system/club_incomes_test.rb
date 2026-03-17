require "application_system_test_case"

class ClubIncomesTest < ApplicationSystemTestCase
  setup do
    @club_income = club_incomes(:one)
  end

  test "visiting the index" do
    visit club_incomes_url
    assert_selector "h1", text: "Club incomes"
  end

  test "should create club income" do
    visit club_incomes_url
    click_on "New club income"

    fill_in "Club profile", with: @club_income.club_profile_id
    fill_in "Date", with: @club_income.date
    fill_in "Description", with: @club_income.description
    fill_in "Value", with: @club_income.value
    click_on "Create Club income"

    assert_text "Club income was successfully created"
    click_on "Back"
  end

  test "should update Club income" do
    visit club_income_url(@club_income)
    click_on "Edit this club income", match: :first

    fill_in "Club profile", with: @club_income.club_profile_id
    fill_in "Date", with: @club_income.date
    fill_in "Description", with: @club_income.description
    fill_in "Value", with: @club_income.value
    click_on "Update Club income"

    assert_text "Club income was successfully updated"
    click_on "Back"
  end

  test "should destroy Club income" do
    visit club_income_url(@club_income)
    accept_confirm { click_on "Destroy this club income", match: :first }

    assert_text "Club income was successfully destroyed"
  end
end
