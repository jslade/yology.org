require 'test_helper'
require 'yology/gender'

class GenderTest < Test::Unit::TestCase
  
  test "constants are defined" do
    assert_not_nil Yology::Gender::UNKNOWN
    assert_not_nil Yology::Gender::MALE
    assert_not_nil Yology::Gender::FEMALE
    assert_not_nil Yology::Gender::NA
  end

  test "String#to_gender" do
    [ 'm', 'M', 'male', 'Male' ].each do |str|
      assert_equal Yology::Gender::MALE, str.to_gender,
        "'#{str}' should be MALE"
    end

    [ 'f', 'F', 'female', 'Female' ].each do |str|
      assert_equal Yology::Gender::FEMALE, str.to_gender,
        "'#{str}' should be FEMALE"
    end
  end
  

end #/GenderTest

