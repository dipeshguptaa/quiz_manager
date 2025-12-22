class Admin::SubmissionsController < Admin::BaseController

  def index
    @selected_quiz = Quiz.find_by(id: params[:quiz_id]) if params[:quiz_id].present?

    if params[:quiz_id].present? && @selected_quiz.nil?
      redirect_to admin_submissions_path, alert: 'Quiz not found'
      return
    end

    @quizzes = Quiz.published.order(:title)

    @submissions =
      if @selected_quiz
        @selected_quiz.submissions.includes(:quiz).order(submitted_at: :desc)
      else
        Submission.includes(:quiz).order(submitted_at: :desc)
      end

    @total_count = @submissions.size
    @today_count = @submissions.today.size
    @week_count = @submissions.this_week.size
    @average_score =
      if @selected_quiz && @submissions.present?
        total_score = @submissions.sum(:score)
        total_questions = @submissions.sum(:total_questions)
        total_questions.zero? ? 0 : ((total_score.to_f / total_questions) * 100).round(1)
      else
        0
      end
  end

  def show
    @submission = Submission.includes(quiz: { questions: :options }, answers: :question).find(params[:id])
  end
end
