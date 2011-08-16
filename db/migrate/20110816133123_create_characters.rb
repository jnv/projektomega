class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.integer :number, null: false
      t.string :name, null: false
      t.string :born
      t.string :country
      t.string :assignment
      t.string :specialisation

      t.timestamps
    end
  end
end
