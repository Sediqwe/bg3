class DropUsersTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :users, force: :cascade
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end