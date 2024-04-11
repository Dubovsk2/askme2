class AddAuthorToQuestions < ActiveRecord::Migration[7.1]
  def change
    change_table :questions do |t|
      t.belongs_to :author, foreign_key: { to_table: :users }
    end
  end
end
