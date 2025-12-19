class QuizzesController < ApplicationController
  def index
    @quizzes = Quiz.where(published: true).order(id: :desc)
  end

  def show
    @quiz = Quiz.includes(questions: :options).find(params[:id])
  end
end
