class Person < ActiveRecord::Base

  
  def is_spouse? spouse
    return false if spouse.nil?

    rtype = Relation.rtype_for_parent(self)
    rel = find_relation(:person1_id => spouse.id, :person2_id => self.id,
                        :rtype => rtype)
    !rel.nil?
  end
  
  def add_spouse spouse
    raise ArgumentError("spouse required") if spouse.nil?
    raise ArgumentError("spouse gender must be different") \
      if spouse.gender == self.gender
    return self if is_spouse?(spouse)
    rtype = Relation.rtype_for_spouse(spouse)
    p1, p2 = Relation.canonical_spouse_relation_order(self,spouse)
    rel = Relation.create(:person1_id => p1.id, :person2_id => p2.id,
                          :rtype => rtype, :tree => tree)
    
    @spouses = nil

    # todo: Add MARRIAGE event? or leave that to some higher-level operation?
    # answer: leave it to be handled at higher level (Tree?)
    
    self
  end
  

  
  
  def spouses
    return @spouses if @spouses
    rtype = Relation.rtype_for_spouse(self)
    p1, p2 = Relation.canonical_spouse_relation_order(self,nil)
    if self == p1
      rel = find_relations(:person1_id => self.id, :rtype => rtype)
      @spouses = rel.map{|r| r.person2}
    elsif self == p2
      rel = find_relations(:person2_id => self.id, :rtype => rtype)
      @spouses = rel.map{|r| r.person1}
    else
      @spouses = []
    end
    @spouses
  end
  
  

  protected
  

  def find_relations(cond={})
    Relation.find(:all,:conditions => cond.merge(default_conditions))
  end
  
  
  def find_relation(cond={})
    Relation.find(:first,:conditions => cond.merge(default_conditions))
  end
  
  
end 
