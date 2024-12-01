class Account < ApplicationRecord
  belongs_to :user
  has_many :app_transactions, dependent: :destroy
end
