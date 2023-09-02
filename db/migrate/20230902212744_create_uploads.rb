class CreateUploads < ActiveRecord::Migration[7.0]
  def change
    create_table :uploads do |t|
      t.string :version
      t.references :game, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :uploadtype
      t.boolean :active

      t.timestamps
    end
  end
end
