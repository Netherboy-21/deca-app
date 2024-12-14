class Account < ApplicationRecord
  belongs_to :user
  has_many :app_transactions, dependent: :destroy

  validates :name, presence: :true
  validates :initial_balance, presence: :true
end
