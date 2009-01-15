class Person < ActiveRecord::Base

  def is_male?
    self.gender == Yology::Gender::MALE
  end
  
  def is_female?
    self.gender == Yology::Gender::FEMALE
  end

  def other_sex
    case self.gender
    when Yology::Gender::MALE
      Yology::Gender::FEMALE
    when Yology::Gender::FEMALE
      Yology::Gender::MALE
    else
      self.gender
    end
  end
  
end
