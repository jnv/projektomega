class AddUserToCharacter < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.references :user
      t.index :user_id
    end
  end

end
