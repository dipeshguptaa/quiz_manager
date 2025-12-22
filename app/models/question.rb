class Question < ApplicationRecord
  belongs_to :quiz, counter_cache: true
  has_many :options, dependent: :destroy
  has_many :answers, dependent: :destroy
  belongs_to :correct_option, class_name: "Option", optional: true

  accepts_nested_attributes_for :options, allow_destroy: true, reject_if: proc { |attrs| attrs['content'].blank? }

  enum question_type: { mcq: 0, true_false: 1, short_text: 2 }

  validates :question_text, :question_type, presence: true

  after_commit :ensure_true_false_options, on: [:create, :update]
  after_commit :ensure_true_false_options, on: [:create, :update]
  
  private

  def ensure_true_false_options
    return unless true_false?

    allowed = ["True", "False"]

    options.where.not(content: allowed).destroy_all

    allowed.each do |value|
      options.find_or_create_by!(content: value)
    end
  end
end
