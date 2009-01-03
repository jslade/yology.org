class Event < ActiveRecord::Base
  belongs_to :tree
  belongs_to :place
  has_many :participants, :dependent => :destroy
  has_many :people, :through => 'Participant'
  has_many :citations, :dependent => :destroy
  has_many :sources, :through => 'Citation'
end
