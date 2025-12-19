class Question < ApplicationRecord
  belongs_to :quiz
  has_many :options, dependent: :destroy

  enum question_type: { mcq: 0, true_false: 1, short_text: 2 }

  validates :question_text, presence: true
end
