class Admin::SubmissionsController < Admin::BaseController

  def index
    @selected_quiz = Quiz.find_by(id: params[:quiz_id]) if params[:quiz_id].present?

    if params[:quiz_id].present? && @selected_quiz.nil?
      redirect_to admin_submissions_path, alert: 'Quiz not found'
      return
    end

    @quizzes = Quiz.published.order(:title)

    base_scope = @selected_quiz ? Submission.where(quiz_id: @selected_quiz.id) : Submission.all

    @total_count = @selected_quiz ? @selected_quiz.submissions_count : Submission.count
    @today_count = base_scope.today.size
    @week_count  = base_scope.this_week.size

    @average_score =
      if @selected_quiz
        total_score, total_questions = base_scope.pick("SUM(score)", "SUM(total_questions)")
        total_questions.positive? ?
          ((total_score.to_f / total_questions) * 100).round(1) :
          0
      end
  
    @submissions = base_scope.includes(:quiz).order(submitted_at: :desc)
  end  

  def show
    @submission = Submission.includes(quiz: { questions: :options }, answers: :question).find(params[:id])
  end
end
