class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :character, :null => false
      t.text :content, :null => false

      t.timestamps
    end
    add_index :posts, :character_id
  end
end
