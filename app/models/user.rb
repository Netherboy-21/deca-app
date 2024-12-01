class User < ApplicationRecord
  # Define relations to other models
  has_many :accounts, dependent: :destroy
  has_many :categories, dependent: :destroy

  # Validate user input
  validates :username, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
end
