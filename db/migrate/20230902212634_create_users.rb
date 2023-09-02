class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :usertype
      t.text :password
      t.boolean :active

      t.timestamps
    end
  end
end
