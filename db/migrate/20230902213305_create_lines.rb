class CreateLines < ActiveRecord::Migration[7.0]
  def change
    create_table :lines do |t|
      t.string :contentuid
      t.string :version
      t.text :content
      t.integer :linieref
      t.integer :datatype
      t.references :game, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :uploadtype
      t.integer :lang
      t.boolean :active

      t.timestamps
    end
  end
end
