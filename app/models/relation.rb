class Relation < ActiveRecord::Base
  belongs_to :tree
  belongs_to :person1, :class_name => 'Person'
  belongs_to :person2, :class_name => 'Person'
  has_many :citations, :dependent => :destroy
  has_many :sources, :through => 'Citation'
  
  
  # ------------------------------------------------------------
  # Rtype values

  UNKNOWN = 0
  
  FATHER = 1
  MOTHER = 2
  
  
  def self.rtype_for_parent(p)
    case p.gender
    when Yology::Gender::MALE
      Relation::FATHER
    when Yology::Gender::FEMALE
      Relation::MOTHER
    else
      Relation::UNKNOWN
    end
  end
      
      
end
