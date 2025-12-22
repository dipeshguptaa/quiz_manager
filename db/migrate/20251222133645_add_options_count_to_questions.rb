class AddOptionsCountToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :options_count, :integer, default: 0, null: false
    add_index  :questions, :options_count
  end  
end
