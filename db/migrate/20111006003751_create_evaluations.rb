class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations, :id => false do |t|
      t.references :mission, :null => false
      t.references :character, :null => false
      t.references :author, :null => false
      t.text :content, :null => false

      t.timestamps
    end
    add_index :evaluations, [:mission_id, :character_id, :author_id], :unique => true
  end
end
