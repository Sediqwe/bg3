class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :desc
      t.references :user, null: false, foreign_key: true
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
