class RemoveNameFromAnswers < ActiveRecord::Migration[5.2]
  def change
    remove_column :answers, :name, :string
  end
end
