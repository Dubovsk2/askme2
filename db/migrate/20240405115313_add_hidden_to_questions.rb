class AddHiddenToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :hidden, :boolean, default: false
  end
end
