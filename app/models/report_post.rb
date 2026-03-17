class ReportPost < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :content, presence: true, length: { minimum: 10, maximum: 500 }
end
