class ReportProfile < ApplicationRecord
  belongs_to :user

  def pending?
    resolved == false
  end

  def resolved?
    resolved == true
  end
end
