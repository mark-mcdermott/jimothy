require "test_helper"

class JimothyTest < ActiveSupport::TestCase
  setup do
    %x(rails g jimothy:install)
  end
  test "it has a version number" do
    assert Jimothy::VERSION
  end
end
