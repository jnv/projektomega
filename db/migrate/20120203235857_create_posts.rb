class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :character
      t.references :user
      t.text :content

      t.timestamps
    end
    add_index :posts, :character_id
    add_index :posts, :user_id
  end
end
