class Person < ActiveRecord::Base
  belongs_to :tree
  has_many :events, :through => 'Participant'
  has_many :relations, :dependent => :destroy

  # Matches values in Yology::Gender
  validates_inclusion_of :gender, :in => [0,1,2,9]
  
  validates_presence_of :tree
  
  require_dependency 'person/children'
  require_dependency 'person/gender'
  require_dependency 'person/name'
  require_dependency 'person/spouses'


  protected


  def before_validation
    super
    self.gender = Yology::Gender::UNKNOWN unless attribute_present?('gender')
  end

  

  # Is there a better way to do this with ActiveRecord contexts?
  def default_conditions
    { :tree_id => tree.id }
  end
  
  
end
