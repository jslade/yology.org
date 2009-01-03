class Source < ActiveRecord::Base
  belongs_to :tree
  belongs_to :parent, :class_name => 'Source'
  has_many :citations, :dependent => :destroy
end
