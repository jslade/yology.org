ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

# custom add-ons
require 'context'
require 'flexmock'
require 'flexmock/test_unit'


class Test::Unit::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end



# courtesy of http://bmorearty.wordpress.com/2008/06/18/find-tests-more-easily-in-your-testlog/
class Test::Unit::TestCase
  # This extension prints to the log before each test.  Makes it easier to find the test you're looking for
  # when looking through a long test log.
  setup :log_test
 
  private
 
  def log_test
    if Rails::logger
      # When I run tests in rake or autotest I see the same log message multiple times per test for some reason.
      # This guard prevents that.
      unless @already_logged_this_test
        Rails::logger.info "\n\nStarting #{@method_name}\n#{'-' * (9 + @method_name.length)}\n"
      end
      @already_logged_this_test = true
    end
  end
end
