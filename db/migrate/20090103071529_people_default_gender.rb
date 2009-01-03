class PeopleDefaultGender < ActiveRecord::Migration
  def self.up
    change_column :people, :gender, :integer,
      :default => Yology::Gender::UNKNOWN
  end

  def self.down
  end
end
