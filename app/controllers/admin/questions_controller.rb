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

    if @question.true_false?
      return unless %w[True False].include?(params[:correct_option_temp])
      option = @question.options.find_or_create_by(content: params[:correct_option_temp])
    else
      key = params[:correct_option_temp].to_s
      option_attrs = params.dig(:question, :options_attributes, key)
      option = @question.options.find_by(content: option_attrs[:content]) if option_attrs
    end

    @question.update_column(:correct_option_id, option.id) if option
  end
end
