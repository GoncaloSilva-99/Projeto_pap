require "application_system_test_case"

class ClubExpensesTest < ApplicationSystemTestCase
  setup do
    @club_expense = club_expenses(:one)
  end

  test "visiting the index" do
    visit club_expenses_url
    assert_selector "h1", text: "Club expenses"
  end

  test "should create club expense" do
    visit club_expenses_url
    click_on "New club expense"

    fill_in "Club profile", with: @club_expense.club_profile_id
    fill_in "Date", with: @club_expense.date
    fill_in "Description", with: @club_expense.description
    fill_in "Value", with: @club_expense.value
    click_on "Create Club expense"

    assert_text "Club expense was successfully created"
    click_on "Back"
  end

  test "should update Club expense" do
    visit club_expense_url(@club_expense)
    click_on "Edit this club expense", match: :first

    fill_in "Club profile", with: @club_expense.club_profile_id
    fill_in "Date", with: @club_expense.date
    fill_in "Description", with: @club_expense.description
    fill_in "Value", with: @club_expense.value
    click_on "Update Club expense"

    assert_text "Club expense was successfully updated"
    click_on "Back"
  end

  test "should destroy Club expense" do
    visit club_expense_url(@club_expense)
    accept_confirm { click_on "Destroy this club expense", match: :first }

    assert_text "Club expense was successfully destroyed"
  end
end
