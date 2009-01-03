class CreateCitations < ActiveRecord::Migration
  def self.up
    create_table :citations do |t|
      t.timestamps
      t.references :source, :null => false
      t.references :event
      t.references :relation
    end
  end

  def self.down
    drop_table :citations
  end
end
