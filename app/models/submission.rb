class Submission < ApplicationRecord
  belongs_to :quiz
  has_many :answers, dependent: :destroy

  def percentage_score
    return 0 if total_questions.nil? || total_questions.zero?
    (score.to_f / total_questions * 100).round(1)
  end

  def performance_level
    percentage = percentage_score
    case percentage
    when 90..100
      { label: '🏆 Excellent!', color: 'green' }
    when 70...90
      { label: '⭐ Great Job!', color: 'blue' }
    when 50...70
      { label: '👍 Good Effort!', color: 'amber' }
    else
      { label: '💪 Keep Practicing!', color: 'red' }
    end
  end

  def score_color
    percentage = percentage_score
    if percentage >= 70
      '#10b981'
    elsif percentage >= 50
      '#f59e0b'
    else
      '#ef4444'
    end
  end
end
