class CreateLogolas < ActiveRecord::Migration[7.0]
  def change
    create_table :logolas do |t|
      t.references :user, null: false, foreign_key: true
      t.string :page
      t.text :desc

      t.timestamps
    end
  end
end
