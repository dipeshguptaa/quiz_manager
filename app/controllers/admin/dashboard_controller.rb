class Admin::DashboardController < Admin::BaseController
  def index
    @quizzes_count = Quiz.count
    @published_quizzes = Quiz.where(published: true).count
    @submissions_count = Submission.count
  end
end
