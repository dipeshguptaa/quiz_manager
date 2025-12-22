class QuizzesController < ApplicationController
  def index
    @quizzes = Quiz.where(published: true).order(id: :desc)
  end

  def show
    @quiz = Quiz.includes(questions: :options).find_by(id: params[:id])

    if @quiz.nil?
      redirect_to quizzes_path, alert: "Quiz not found"
      return
    end

    unless @quiz.published?
      redirect_to quizzes_path, alert: "This quiz is not published yet"
      return
    end

    @quiz_questions = @quiz.questions
  end
  
end
