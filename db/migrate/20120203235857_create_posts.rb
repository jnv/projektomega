class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :character, :null => false
      t.references :user, :null => false
      t.text :content, :null => false

      t.timestamps
    end
    add_index :posts, :character_id
    add_index :posts, :user_id
  end
end
