class Question < ApplicationRecord
  belongs_to :quiz
  has_many :options, dependent: :destroy
  belongs_to :correct_option, class_name: "Option", optional: true

  accepts_nested_attributes_for :options, allow_destroy: true

  enum question_type: { mcq: 0, true_false: 1, short_text: 2 }

  validates :question_text, :question_type, presence: true

  after_commit :ensure_true_false_options

  private

  def ensure_true_false_options
    return unless true_false?
    return if options.exists?

    options.create!([{ content: "True" }, { content: "False" }])
  end
end
