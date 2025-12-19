class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :quiz, null: false, foreign_key: true
      t.text :question_text
      t.integer :question_type
      t.integer :correct_option_id
      t.integer :position

      t.timestamps
    end
  end
end
