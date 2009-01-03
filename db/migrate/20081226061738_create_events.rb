class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.timestamps
      t.references :tree, :null => false
      t.references :place
      t.string :date, :null => false
      t.text :note
    end
  end

  def self.down
    drop_table :events
  end
end
