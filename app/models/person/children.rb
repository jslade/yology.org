class Person < ActiveRecord::Base

  
  def is_child? child
    return false if child.nil?
    rel = find_relation(:person1_id => child.id, :person2_id => self.id)
    !rel.nil?
  end
  
  def add_child child
    raise ArgumentError("child required") if child.nil?
    return self if is_child?(child)
    rtype = Relation.rtype_for_parent(self)
    rel = Relation.create(:person1_id => child.id, :person2_id => self.id,
                          :rtype => rtype, :tree => tree)
    @children = nil
    
    
    # todo: Add BIRTH event
    
    self
  end
  

  
  
  def children
    return @children if @children
    rel = find_relations(:person2_id => self.id,
                         :rtype => Relation.rtype_for_parent(self))
    @children = rel.map{|r| r.person1}
  end
  
  def father
    return @father if @father
    rel = find_relation(:person1_id => self.id,
                         :rtype => Relation::FATHER)
    @father = rel ? rel.person2 : nil
  end
  
  def mother
    return @mother if @mother
    rel = find_relation(:person1_id => self.id,
                        :rtype => Relation::MOTHER)
    @mother = rel ? rel.person2 : nil
  end

  def siblings
    one = father ? father.children : []
    two = mother ? mother.children : []
    [ one, two ].flatten.unique
  end
  

  protected
  

  def find_relations(cond={})
    Relation.find(:all,:conditions => cond.merge(default_conditions))
  end
  
  
  def find_relation(cond={})
    Relation.find(:first,:conditions => cond.merge(default_conditions))
  end
  
  
end 
