class AddNameAndRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    change_column :users, :name, :string, null: false #Makes a lot of fucking sense. http://strd6.com/2009/04/adding-a-non-null-column-with-no-default-value-in-a-rails-migration/

    add_column :users, :role, :string, null: false, default: 'user'

    add_index :users, :name, unique: true
  end
end
