class CreateSources < ActiveRecord::Migration
  def self.up
    create_table :sources do |t|
      t.timestamps
      t.references :tree, :null => false
      t.text :source_text, :null => false
      t.references :parent
      t.integer :order, :null => false, :default => 1
    end
  end

  def self.down
    drop_table :sources
  end
end
