class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.timestamps
      t.references :person, :null => false
      t.references :event, :null => false
      t.boolean :is_principal, :default => false
      t.integer :order, :null => false, :default => 1
    end
    
    add_index :participants, :person_id
    add_index :participants, :event_id
  end

  def self.down
    drop_table :participants
  end
end
