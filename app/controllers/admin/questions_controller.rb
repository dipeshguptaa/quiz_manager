class Admin::QuestionsController < Admin::BaseController
  before_action :set_quiz
  before_action :set_question, only: [:edit, :update, :destroy]

  def index
    redirect_to admin_quiz_path(params[:quiz_id])
  end

  def new
    @question = @quiz.questions.new
    @question.options.build
  end

  def create
    @question = @quiz.questions.new(question_params)

    if @question.save
      assign_correct_option
      redirect_to admin_quiz_questions_path(@quiz), notice: "Question added"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      assign_correct_option
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
    params.require(:question).permit(:question_text, :question_type, :position, options_attributes: [:id, :content, :_destroy])
  end

  def assign_correct_option
    return unless params[:correct_option_temp]
    index = params[:correct_option_temp].to_i
    option = @question.options[index]
    @question.update_column(:correct_option_id, option.id) if option
  end
end
