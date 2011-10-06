class AddPortraitToCharacters < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.string :portrait
    end
  end
end
