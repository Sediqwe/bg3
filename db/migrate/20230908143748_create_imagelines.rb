class CreateImagelines < ActiveRecord::Migration[7.0]
  def change
    create_table :imagelines do |t|
      t.references :image, null: false, foreign_key: true
      t.references :line, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :done
      t.boolean :active

      t.timestamps
    end
  end
end
