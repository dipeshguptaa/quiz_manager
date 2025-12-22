class AddSubmissionsCountToQuizzes < ActiveRecord::Migration[6.1]
  def up
    add_column :quizzes, :submissions_count, :integer, default: 0, null: false

    # Backfill existing data
    Quiz.reset_column_information
    Quiz.find_each do |quiz|
      Quiz.reset_counters(quiz.id, :submissions)
    end
  end

  def down
    remove_column :quizzes, :submissions_count
  end
end
