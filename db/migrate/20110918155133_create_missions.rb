class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.integer :number, null: false
      t.string :name, null: false
      t.string :date
      t.string :location
      t.text :description

      t.timestamps
    end
  end
end
