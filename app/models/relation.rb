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

  SPOUSE = 10
  DOMESTIC_PARTNER = 11
  
  
  
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

  
  def self.rtype_for_spouse(p)
    Relation::SPOUSE
  end

  def self.canonical_spouse_relation_order(p1,p2)
    if p1
      if p1.is_male?
        return [ p1, p2 ]
      elsif p1.is_female?
        return [ p2, p1 ]
      end
    elsif p2
      if p2.is_male?
        return [ p2, p1 ]
      elsif p2.is_female?
        return [ p1, p2 ]
      end
    end
    [ nil, nil ]
  end
        
end
