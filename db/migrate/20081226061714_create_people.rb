class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.timestamps
      t.references :tree, :null => false
      t.integer :gender, :limit => 1, :null => false
      t.string :name
      t.string :given
      t.string :surname
    end
  end

  def self.down
    drop_table :people
  end
end
