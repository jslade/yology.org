require 'test_helper'

class PersonTest < Test::Unit::TestCase
  context "names" do
    before do |*opt|
      @person = Person.new(:name => "John Smith")
    end
    
    test "name, given, surname can be different" do
      assert_equal "John Smith", @person.name
      assert_equal "John", @person.given
      assert_equal "Smith", @person.surname
    end
    
    test "set and unset explicit given" do
      @person.given = "Johnny"
      assert_equal "Johnny", @person.given
      @person.given = nil
      assert_equal "John", @person.given
    end
    
    test "set and unset explicit surname" do
      @person.surname = "SMITH"
      assert_equal "SMITH", @person.surname
      @person.surname = nil
      assert_equal "Smith", @person.surname
    end
    
    test "extract surname" do
      [ [ 'John SMITH', 'SMITH' ],
        [ 'John /Smith/', 'Smith' ],
        [ 'Smith, John', 'Smith' ],
        [ 'Joe VAN NESS', 'VAN NESS' ],
        [ 'Brent J Slade', 'Slade' ],
        [ 'Brent J SLADE', 'SLADE' ],
      ].each do |full,sur|
        assert_equal sur, Person.extract_surname_from_fullname(full),
          "Surname from '#{full}' should be '#{sur}'"
      end
    end
    
    test "extract given" do
      [ [ 'John SMITH', 'John' ],
        [ 'John /Smith/', 'John' ],
        [ 'Smith, John', 'John' ],
        [ 'Joe VAN NESS', 'Joe' ],
        [ 'Brent J Slade', 'Brent' ],
        [ 'Brent J SLADE', 'Brent' ],
      ].each do |full,given|
        assert_equal given, Person.extract_given_from_fullname(full),
          "Given from '#{full}' should be '#{given}'"
      end
    end
    
  end #/ names

  
  context "gender" do
    before do
      @person = Person.new(:name => "John Smith", :tree => trees(:test))
    end
    
    test "validates gender is set" do
      assert_equal nil, @person.gender
      assert_equal true, @person.save
      @person.reload
      assert_equal Yology::Gender::UNKNOWN, @person.gender
    end

  
    test "constrains gender to valid values" do
      [ Yology::Gender::UNKNOWN,
        Yology::Gender::MALE,
        Yology::Gender::FEMALE,
        Yology::Gender::NA ].each do |g|
        @person.gender = g
        assert_equal true, @person.save
      end
      [ -1, 3, 99 ].each do |g|
        @person.gender = g
        assert_equal false, @person.save
      end
    end

  end
  
  
  context "children" do
    before do
      @brother = Person.create(:name => "Joe Smith", :tree => trees(:test),
                             :gender => Yology::Gender::MALE)
      @sister = Person.create(:name => "Jane Smith", :tree => trees(:test),
                             :gender => Yology::Gender::FEMALE)
      @father = Person.create(:name => "Pop Smith", :tree => trees(:test),
                             :gender => Yology::Gender::MALE)
      @mother = Person.create(:name => "Mom Smith", :tree => trees(:test),
                              :gender => Yology::Gender::FEMALE)
      
    end

    
    test "add father's child" do
      assert_equal 0, @father.children.size
      assert_difference 'Relation.count', 1 do
        @father.add_child(@brother)
      end
      assert_equal 1, @father.children.size
      assert_equal @brother, @father.children[0]
      assert_equal @father, @brother.father

      # No change for adding it again
      assert_no_difference 'Relation.count' do
        @father.add_child(@brother)
      end
    end


    test "add mother's child" do
      assert_equal 0, @mother.children.size
      assert_difference 'Relation.count', 1 do
        @mother.add_child(@brother)
      end
      assert_equal 1, @mother.children.size
      assert_equal @brother, @mother.children[0]
      assert_equal @mother, @brother.mother
      
      # add next child
      assert_difference 'Relation.count', 1 do
        @mother.add_child(@sister)
      end
      assert_equal 2, @mother.children.size
      assert_equal @mother, @sister.mother
    end
    
  end
  
  
end
