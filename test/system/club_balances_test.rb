require "application_system_test_case"

class ClubBalancesTest < ApplicationSystemTestCase
  setup do
    @club_balance = club_balances(:one)
  end

  test "visiting the index" do
    visit club_balances_url
    assert_selector "h1", text: "Club balances"
  end

  test "should create club balance" do
    visit club_balances_url
    click_on "New club balance"

    fill_in "Club profile", with: @club_balance.club_profile_id
    fill_in "Value", with: @club_balance.value
    click_on "Create Club balance"

    assert_text "Club balance was successfully created"
    click_on "Back"
  end

  test "should update Club balance" do
    visit club_balance_url(@club_balance)
    click_on "Edit this club balance", match: :first

    fill_in "Club profile", with: @club_balance.club_profile_id
    fill_in "Value", with: @club_balance.value
    click_on "Update Club balance"

    assert_text "Club balance was successfully updated"
    click_on "Back"
  end

  test "should destroy Club balance" do
    visit club_balance_url(@club_balance)
    accept_confirm { click_on "Destroy this club balance", match: :first }

    assert_text "Club balance was successfully destroyed"
  end
end
