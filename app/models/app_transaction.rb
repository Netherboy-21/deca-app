class AppTransaction < ApplicationRecord
  belongs_to :account

  validates :amount, presence: true
  validates_numericality_of :amount, greater_than: 0
  validates_numericality_of :amount, digits: 2
end
