class CreateSubmissions < ActiveRecord::Migration[6.1]
  def change
    create_table :submissions do |t|
      t.references :quiz, null: false, foreign_key: true
      t.integer :score
      t.integer :total_questions
      t.datetime :submitted_at

      t.timestamps
    end
  end
end
