class Person < ActiveRecord::Base
  # Name must be set
  validates_presence_of :name, :length => 0..255

  
  def given
    return @given if @given
    @given = self.attributes['given'] ||
      Person.extract_given_from_fullname(name)
  end

  def given= val
    @given = val
    self.attributes['given'] = val
  end

  def surname
    return @surname if @surname
    @surname = self.attributes['surname'] ||
      Person.extract_surname_from_fullname(name)
  end
  
  def surname= val
    @surname = val
    self.attributes['surname'] = val
  end


  
  
  protected
  
  
  def self.extract_given_from_fullname n
    if n =~ %r{^.+, ?(.+)$}o
      $1.split(' ')[0]
    else
      n.split(' ')[0]
    end
  end
  
  
  def self.extract_surname_from_fullname n
    if n =~ %r{^(.+), ?.+$}o
      $1.dup
    elsif n =~ %r{/(.+)/}o
      $1.dup
    elsif n =~ %r{(^| +)(([A-Z]{2,}( +|$))+)}o
      $2.dup
    else
      n.split(' ')[-1]
    end
  end
  
  
end

