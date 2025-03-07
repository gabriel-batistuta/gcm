class AddTemporaryToUsers < ActiveRecord::Migration[8.0]
  def change
    unless column_exists?(:users, :temporary)
      add_column :users, :temporary, :boolean, default: true, null: false
    end
  end
end
