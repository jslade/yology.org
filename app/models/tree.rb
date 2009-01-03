class Tree < ActiveRecord::Base
  belongs_to :user
  has_many :people, :dependent => :destroy
  has_many :relations, :dependent => :destroy
  has_many :events, :dependent => :destroy
  has_many :places, :dependent => :destroy
  has_many :sources, :dependent => :destroy
end
