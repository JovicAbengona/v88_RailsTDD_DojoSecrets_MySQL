class Secret < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  validates :user_id, presence: true
  validates :content, presence: true
end
