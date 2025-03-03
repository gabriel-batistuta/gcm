# db/migrate/20250228000000_create_users.rb
class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :email
      t.string  :password_digest
      t.boolean :admin, default: false
      t.boolean :temporary, default: true  # senha provisória

      t.timestamps
    end
  end
end
