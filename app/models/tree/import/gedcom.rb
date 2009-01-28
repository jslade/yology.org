# Uses gedcom-ruby parser
require 'gedcom'
require 'ostruct'

class Tree < ActiveRecord::Base

  def import_gedcom path
    raise ArgumentError.new("No such file: #{path}") unless
      File.exist?(path)

    
    
  end
  

  
  class GedcomImporter < GEDCOM::Parser
    attr_accessor :unknown_tags,
      :individuals, :rin_map
      
    def initialize
      super
      
      @individuals = []
      @families = []
      @relations = []
      @events = []

      @rins = []
      @mrins = []

      @unknown_tags = {}
      before :any do |tag,data|
        tag = tag.join('_')
        @unkown_tags[tag] ||= 0
        @unkown_tags[tag] += 1
      end
        
      before %w(INDI), :start_indi
      after %w(INDI), :end_indi
    end
    
    
    def start_indi data
      @curr_indi = { :rin => data }
      @rins[data] = @curr_indi
    end
    
    def end_indi data
    end
    
    
  end
  
end


