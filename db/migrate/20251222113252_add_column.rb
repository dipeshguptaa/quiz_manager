class AddColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :quizzes, :timer, :integer
  end
end
