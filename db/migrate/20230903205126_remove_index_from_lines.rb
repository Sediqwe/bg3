class RemoveIndexFromLines < ActiveRecord::Migration[7.0]
  def change
    remove_index :lines, :content
  end
end
