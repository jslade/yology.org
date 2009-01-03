class Citation < ActiveRecord::Base
  belongs_to :source
  
  # either one of these:
  belongs_to :event
  belongs_to :relation
end
