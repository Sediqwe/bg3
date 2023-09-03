class AddOkeToliness < ActiveRecord::Migration[7.0]
  def change
    add_column :lines, :oke, :boolean, default: false
  end
end
