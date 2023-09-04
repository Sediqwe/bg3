class AddToUploadsReadxml < ActiveRecord::Migration[7.0]
  def change
    add_column :uploads, :readxml, :boolean, default:false
    add_column :uploads, :selected, :boolean, default:false
  end
end
