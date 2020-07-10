class RenameNameColumnToInquiries < ActiveRecord::Migration[5.2]
  def change
    rename_column :inquiries, :name, :email
  end
end
