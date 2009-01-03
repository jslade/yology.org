require 'test_helper'

class RelationTest < Test::Unit::TestCase
  
  context "parents" do
    before do 
      @father = flexmock(:gender => Yology::Gender::MALE)
      @mother = flexmock(:gender => Yology::Gender::FEMALE)
    end
    
    test "father" do
      assert_equal Relation::FATHER, Relation.rtype_for_parent(@father)
    end
    
    test "mother" do
      assert_equal Relation::MOTHER, Relation.rtype_for_parent(@mother)
    end
    
  end #/ parents
  
  
end
