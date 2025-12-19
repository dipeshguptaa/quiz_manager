class Admin::QuestionsController < Admin::BaseController
  before_action :set_quiz
  before_action :set_question, only: [:edit, :update, :destroy]

  def index
    @questions = @quiz.questions.order(:position)
  end

  def new
    @question = @quiz.questions.new
  end

  def create
    @question = @quiz.questions.new(question_params)

    if @question.save
      redirect_to admin_quiz_questions_path(@quiz), notice: "Question added"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to admin_quiz_questions_path(@quiz), notice: "Question updated"
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to admin_quiz_questions_path(@quiz), notice: "Question deleted"
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def set_question
    @question = @quiz.questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:question_text, :question_type, :correct_option_id, :position, options_attributes: [:id, :content, :_destroy])
  end
end
