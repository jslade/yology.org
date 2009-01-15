require 'test_helper'
require 'yology/gender'

class PersonTest < Test::Unit::TestCase
  include Yology
  
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
      @person = Person.new(:name => "John Doe", :tree => trees(:test))
    end
    
    test "validates gender is set" do
      assert_equal nil, @person.gender
      assert_equal true, @person.save
      @person.reload
      assert_equal Gender::UNKNOWN, @person.gender
    end

  
    test "constrains gender to valid values" do
      [ Gender::UNKNOWN,
        Gender::MALE,
        Gender::FEMALE,
        Gender::NA ].each do |g|
        @person.gender = g
        assert_equal true, @person.save
      end
      [ -1, 3, 99 ].each do |g|
        @person.gender = g
        assert_equal false, @person.save
      end
    end

    
    test "maleness" do
      @person.gender = Gender::MALE
      assert_equal true, @person.is_male?
      assert_equal false, @person.is_female?
      assert_equal Gender::FEMALE, @person.other_sex
    end

    test "femaleness" do
      @person.gender = Gender::FEMALE
      assert_equal true, @person.is_female?
      assert_equal false, @person.is_male?
      assert_equal Gender::MALE, @person.other_sex
    end

    test "other_sex for non-gender" do
      @person.gender = Gender::UNKNOWN
      assert_equal Gender::UNKNOWN, @person.other_sex
      @person.gender = Gender::NA
      assert_equal Gender::NA, @person.other_sex
    end
    
  end
  
  
  context "children" do
    before do
      @brother = Person.create(:name => "Joe Smith", :tree => trees(:test),
                             :gender => Gender::MALE)
      @sister = Person.create(:name => "Jane Smith", :tree => trees(:test),
                             :gender => Gender::FEMALE)
      @father = Person.create(:name => "Pop Smith", :tree => trees(:test),
                             :gender => Gender::MALE)
      @mother = Person.create(:name => "Mom Smith", :tree => trees(:test),
                              :gender => Gender::FEMALE)
      
    end

    
    test "add father's child" do
      assert_equal 0, @father.children.size
      assert_difference 'Relation.count', 1 do
        @father.add_child(@brother)
      end
      [ @father, @brother ].map(&:reload)
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
      [ @mother, @brother ].map(&:reload)
      assert_equal 1, @mother.children.size
      assert_equal @brother, @mother.children[0]
      assert_equal @mother, @brother.mother
      
      # add next child
      assert_difference 'Relation.count', 1 do
        @mother.add_child(@sister)
      end
      [ @mother, @sister ].map(&:reload)
      assert_equal 2, @mother.children.size
      assert_equal @mother, @sister.mother
    end
    
  end
  

  context "spouses" do
    before do
      @joe = Person.create(:name => "Joe Smith", :tree => trees(:test),
                           :gender => Gender::MALE)
      @jane = Person.create(:name => "Jane Smith", :tree => trees(:test),
                             :gender => Gender::FEMALE)
      @jack = Person.create(:name => "Jack Smith", :tree => trees(:test),
                             :gender => Gender::MALE)
      @jill = Person.create(:name => "Jill Smith", :tree => trees(:test),
                            :gender => Gender::FEMALE)
    end
    
    
    test "Joe and Jane are married" do
      assert_difference 'Relation.count', 1 do
        @joe.add_spouse(@jane)
      end
      [ @joe, @jane ].map(&:reload)
      assert_equal [@jane], @joe.spouses
      assert_equal [@joe], @jane.spouses
    end
    
    
    test "Jane has children by two men, but only one spouse" do
      assert_difference 'Relation.count', 4 do
        @jane.add_spouse(@joe)
        @jane.add_child(@jack)
        @jane.add_child(@jill)
        @joe.add_child(@jill)
      end
      [ @joe, @jane ].map(&:reload)
      assert_equal [@jane], @joe.spouses
      assert_equal [@joe], @jane.spouses
    end
    
    
    test "Jack and Jill are not married" do
      @child = Person.create(:name => "Sonny Smith", :tree => trees(:test),
                            :gender => Gender::MALE)
      @jack.add_child(@child)
      @jill.add_child(@child)
      assert_equal 0, @jack.spouses.size
      assert_equal 0, @jill.spouses.size
    end
  end
  
    
end
