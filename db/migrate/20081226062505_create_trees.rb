class CreateTrees < ActiveRecord::Migration
  def self.up
    create_table :trees do |t|
      t.timestamps
      t.references :user
      t.string :name
      t.text :description
    end
  end

  def self.down
    drop_table :trees
  end
end
