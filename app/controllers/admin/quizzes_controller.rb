class Admin::QuizzesController < Admin::BaseController

  def index
    @quizzes = Quiz.order(id: :desc).load

    @total_quizzes = @quizzes.size
    @published_count = @quizzes.count(&:published?)
    @draft_count = @total_quizzes - @published_count
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    if @quiz.save
      redirect_to admin_quizzes_path, notice: "Quiz created successfully"
    else
      render :new
    end
  end

  def show
    @quiz = Quiz.find(params[:id])
    @questions = @quiz.questions.order(:position)
  end

  def edit
    @quiz = Quiz.find(params[:id])
  end

  def update
    @quiz = Quiz.find(params[:id])
    if @quiz.update(quiz_params)
      redirect_to admin_quizzes_path, notice: "Quiz updated"
    else
      render :edit
    end
  end

  def destroy
    Quiz.find(params[:id]).destroy
    redirect_to admin_quizzes_path
  end

  private

  def quiz_params
    params.require(:quiz).permit(:title, :description, :published, :timer)
  end
end
