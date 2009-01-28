require 'test_helper'

class TreeImportGedcomTest < Test::Unit::TestCase

  context "test_parser" do
    before do |*opt|
      @ged = Tree::GedcomImporter.new
    end
    
  
    test "parse empty" do
      @ged.parse "\n\n"
      assert_equal 0, @ged.individuals.size
    end
  end
  
  
end
