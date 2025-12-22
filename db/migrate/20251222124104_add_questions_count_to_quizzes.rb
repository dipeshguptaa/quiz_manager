class AddQuestionsCountToQuizzes < ActiveRecord::Migration[6.1]
  def change
    add_column :quizzes, :questions_count, :integer
  end
end
