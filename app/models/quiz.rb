class Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :submissions, dependent: :destroy

  validates :title, presence: true
  validates :timer, numericality: { greater_than: 0 }, allow_nil: true

  validate :must_have_at_least_one_question, if: :published?

  scope :published, -> { where(published: true) }
  scope :drafts,    -> { where(published: false) }

  private

  def must_have_at_least_one_question
    if questions.blank?
      errors.add(:base, "Quiz must have at least one question before publishing")
    end
  end
end
