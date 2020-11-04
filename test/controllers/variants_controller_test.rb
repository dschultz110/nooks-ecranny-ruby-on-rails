require 'test_helper'

class VariantsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get variants_index_url
    assert_response :success
  end

  test "should get show" do
    get variants_show_url
    assert_response :success
  end

end
