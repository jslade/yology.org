class User < ActiveRecord::Base
  # todo: should this be dependent?  or should the tree become orphaned
  # in the case of the user being deleted?
  has_many :trees, :dependent => :destroy
end
