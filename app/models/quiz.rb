class Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :submissions, dependent: :destroy

  validates :title, presence: true
end
