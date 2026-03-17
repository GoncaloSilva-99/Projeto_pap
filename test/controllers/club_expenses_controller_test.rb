require "test_helper"

class ClubExpensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club_expense = club_expenses(:one)
  end

  test "should get index" do
    get club_expenses_url
    assert_response :success
  end

  test "should get new" do
    get new_club_expense_url
    assert_response :success
  end

  test "should create club_expense" do
    assert_difference("ClubExpense.count") do
      post club_expenses_url, params: { club_expense: { club_profile_id: @club_expense.club_profile_id, date: @club_expense.date, description: @club_expense.description, value: @club_expense.value } }
    end

    assert_redirected_to club_expense_url(ClubExpense.last)
  end

  test "should show club_expense" do
    get club_expense_url(@club_expense)
    assert_response :success
  end

  test "should get edit" do
    get edit_club_expense_url(@club_expense)
    assert_response :success
  end

  test "should update club_expense" do
    patch club_expense_url(@club_expense), params: { club_expense: { club_profile_id: @club_expense.club_profile_id, date: @club_expense.date, description: @club_expense.description, value: @club_expense.value } }
    assert_redirected_to club_expense_url(@club_expense)
  end

  test "should destroy club_expense" do
    assert_difference("ClubExpense.count", -1) do
      delete club_expense_url(@club_expense)
    end

    assert_redirected_to club_expenses_url
  end
end
