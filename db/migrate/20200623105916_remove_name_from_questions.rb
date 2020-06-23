class RemoveNameFromQuestions < ActiveRecord::Migration[5.2]
  def change
    remove_column :questions, :name, :string
  end
end
