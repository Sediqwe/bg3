class AddLangToUploads < ActiveRecord::Migration[7.0]
  def change
    add_column :uploads, :lang, :string
  end
end
