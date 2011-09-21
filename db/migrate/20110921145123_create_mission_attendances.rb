class CreateMissionAttendances < ActiveRecord::Migration
  def change
    create_table :mission_attendances, id: false do |t|
      t.references :mission
      t.references :character
    end
    add_index :mission_attendances, [:mission_id, :character_id], :unique => true
  end
end
