class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.references :upload, null: false, foreign_key: true
      t.string :title
      t.text :desc
      t.boolean :active, default: false
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
