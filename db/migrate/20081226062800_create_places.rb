class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.timestamps
      t.references :tree, :null => false
      t.string :level1
      t.string :level2
      t.string :level3
      t.string :level4
      t.string :level5
    end
  end

  def self.down
    drop_table :places
  end
end
