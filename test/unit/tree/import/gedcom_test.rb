require 'test_helper'

class TreeImportGedcomTest < Test::Unit::TestCase

  context "test_parser" do
    before do |*opt|
      @ged = Tree::GedcomImporter.new
    end
    
  
    test "parse empty" do
      @ged.parse "\n\n"
      assert_equal 0, @ged.individuals.size
      assert_equal 0, @ged.unknown_tags.size
    end
    
    test "parse individual" do
      @ged.parse <<END
0 @FATHER@ INDI
1 NAME /Father/
1 SEX M
1 BIRT
2 PLAC birth place
2 DATE 1 JAN 1899
1 DEAT
2 PLAC death place
2 DATE 31 DEC 1990
1 FAMS @FAMILY@
END
      assert_equal 1, @ged.individuals.size
      indi = @ged.individuals[0]
      assert_equal Yology::Gender::MALE, indi.gender
      
      assert_equal 0, @ged.unknown_tags.size
    end
  end

  
end
