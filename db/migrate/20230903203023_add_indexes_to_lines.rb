class AddIndexesToLines < ActiveRecord::Migration[7.0]
  def change
    add_index :lines, :datatype
    add_index :lines, :contentuid
    add_index :lines, :content
    add_index :lines, :version    
  end
end
