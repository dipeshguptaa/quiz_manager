class Question < ApplicationRecord
  belongs_to :quiz
  has_many :options, dependent: :destroy

  accepts_nested_attributes_for :options, allow_destroy: true

  enum question_type: { mcq: 0, true_false: 1, short_text: 2 }

  after_save :ensure_true_false_options

  private

  def ensure_true_false_options
    return unless true_false?

    options.destroy_all
    options.create!([{ content: "True" }, { content: "False" }])
  end
end
