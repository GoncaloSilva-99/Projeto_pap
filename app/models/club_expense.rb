class ClubExpense < ApplicationRecord
  belongs_to :club_profile

  after_create  :add_to_balance
  after_destroy :remove_from_balance

  private

  def add_to_balance
    balance.decrement!(:value, value)
  end

  def remove_from_balance
    balance.increment!(:value, value)
  end

  def balance
    club_profile.club_balance
  end
end
