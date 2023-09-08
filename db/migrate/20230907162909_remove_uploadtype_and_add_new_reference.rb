class RemoveUploadtypeAndAddNewReference < ActiveRecord::Migration[7.0]
  def change
    remove_column :lines, :uploadtype
    add_reference :lines, :upload, foreign_key: true
  end
end
