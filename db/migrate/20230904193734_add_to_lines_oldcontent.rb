class AddToLinesOldcontent < ActiveRecord::Migration[7.0]
  def change
    add_column :lines, :oldcontent, :text
  end
end
