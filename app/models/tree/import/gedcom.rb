# Uses gedcom-ruby parser
require 'yology/gender'

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

      @rins = {}
      @mrins = {}

      @unknown_tags = Hash.new
      before :any do |tag,data|
        tag = tag.join('_')
        @unknown_tags[tag] ||= 0
        @unknown_tags[tag] += 1
      end

      define_indi_tags
    end
    

    def define_indi_tags
      before %w(INDI) do |data|
        @individuals << @curr_indi = OpenStruct.new
        @curr_indi.rin = data
        @rins[data] = @curr_indi
      end

      before %w(INDI NAME) do |data|
        @curr_indi.name = data
      end

      before %w(INDI SEX) do |data|
        @curr_indi.gender = data.to_gender
      end

      before %w(INDI BIRT) do |data|
      end
      before %w(INDI BIRT DATE) do |data|
      end
      before %w(INDI BIRT PLAC) do |data|
      end
      
      before %w(INDI DEAT) do |data|
      end
      before %w(INDI DEAT DATE) do |data|
      end
      before %w(INDI DEAT PLAC) do |data|
      end

      before %w(INDI FAMS) do |data|
        @curr_indi.fam_as_spouse = data
      end
      
    end #/define_indi_tags
  end #/ GedcomImporter
  
end #/Tree



