class AppTransaction < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :amount, presence: true
  validates_numericality_of :amount, greater_than: 0
end
