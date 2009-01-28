
module Yology
  module Gender
    
    UNKNOWN = 0
    MALE = 1
    FEMALE = 2
    NA = 9

    def self.gender_from_string str
      case str
      when /^[mM]$/: Gender::MALE
      when /(?i)^male$/: Gender::MALE
      when /^[fF]$/: Gender::FEMALE
      when /(?i)^female$/: Gender::FEMALE
      else Gender::UNKNOWN
      end
    end
  end
end

class String
  def to_gender
    Yology::Gender.gender_from_string self
  end
end

