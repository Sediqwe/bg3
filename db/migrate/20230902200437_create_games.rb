class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.text :name
      t.text :desc
      t.boolean :active

      t.timestamps
    end
  end
end
