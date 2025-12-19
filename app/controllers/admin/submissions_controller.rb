class Admin::SubmissionsController < Admin::BaseController
  def index
    @submissions = Submission.includes(:quiz).order(submitted_at: :desc)
  end

  def show
    @submission = Submission.includes(quiz: { questions: :options }, answers: :question).find(params[:id])
  end
end
