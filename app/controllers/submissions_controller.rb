class SubmissionsController < ApplicationController
  def create
    quiz = Quiz.includes(questions: :options).find(params[:quiz_id])

    submission = quiz.submissions.create!(total_questions: quiz.questions.count, submitted_at: Time.current)
    score = 0

    quiz.questions.each do |question|
      user_answer = params.dig(:answers, question.id.to_s)

      is_correct =
        if question.mcq? || question.true_false?
          question.correct_option_id.to_s == user_answer
        else
          false
        end

      score += 1 if is_correct

      submission.answers.create!(question: question, option_id: user_answer.presence, answer_text: user_answer, is_correct: is_correct)
    end

    submission.update!(score: score)
    redirect_to submission_path(submission)
  end

  def show
    @submission = Submission.includes(quiz: { questions: :options }, answers: :question).find_by(id: params[:id])

    if @submission.nil?
      redirect_to root_path, alert: "Submission not found"
      return
    end
  end
end
