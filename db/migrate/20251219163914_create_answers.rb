class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.references :submission, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.integer :option_id
      t.text :answer_text
      t.boolean :is_correct

      t.timestamps
    end
  end
end
