class Submission < ApplicationRecord
  belongs_to :quiz, counter_cache: true
  has_many :answers, dependent: :destroy

  scope :today, -> { where('submitted_at >= ?', Time.zone.today.beginning_of_day) }
  scope :this_week, -> { where('submitted_at >= ?', 1.week.ago) }

  # ---------- Scores ----------

  def percentage_score
    return 0.0 if total_questions.to_i.zero?
    ((score.to_f / total_questions) * 100).round(1)
  end

  def score_label
    "#{score} / #{total_questions}"
  end

  # ---------- Performance ----------

  def performance_level
    case percentage_score
    when 90..100
      { label: '🏆 Excellent!', admin_label: '🏆 Excellent', color: 'green' }
    when 70...90
      { label: '⭐ Great Job!', admin_label: '⭐ Good', color: 'blue' }
    when 50...70
      { label: '👍 Good Effort!', admin_label: '👍 Fair', color: 'amber' }
    else
      { label: '💪 Keep Practicing!', admin_label: '💪 Needs Work', color: 'red' }
    end
  end

  # ---------- UI helpers ----------

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

  def badge_classes
    {
      green:  'bg-green-100 text-green-800',
      blue:   'bg-blue-100 text-blue-800',
      amber:  'bg-amber-100 text-amber-800',
      red:    'bg-red-100 text-red-800'
    }[performance[:badge]]
  end

  def progress_bar_style
    "width: #{percentage_score}%"
  end

  # ---------- Class-level stats ----------

  def self.average_percentage
    return 0.0 if none?
    total_score = sum(:score)
    total_questions = sum(:total_questions)
    return 0.0 if total_questions.zero?
    ((total_score.to_f / total_questions) * 100).round(1)
  end
end
