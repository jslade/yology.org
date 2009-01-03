class CreateRelations < ActiveRecord::Migration
  def self.up
    create_table :relations do |t|
      t.timestamps
      t.references :tree, :null => false
      t.references :person1, :null => false
      t.references :person2, :null => false
      t.integer :rtype, :null => false
    end
    
    add_index :relations, :rtype
    add_index :relations, :person1_id
    add_index :relations, :person2_id
    add_index :relations, [:person1_id, :rtype], :name => 'person1_rtype'
    add_index :relations, [:person2_id, :rtype], :name => 'person2_rtype'
  end

  def self.down
    drop_table :relations
  end
end
