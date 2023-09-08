class CreateLexicons < ActiveRecord::Migration[7.0]
  def change
    create_table :lexicons do |t|
      t.references :user, null: false, foreign_key: true
      t.string :word
      t.boolean :active
      t.string :wordhu
      t.string :lang

      t.timestamps
    end
  end
end
