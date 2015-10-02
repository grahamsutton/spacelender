require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase
  test "should call the create action" do
    post :create
    assert_response :success
  end

  test "create action should get the current user" do
    post :create
    assert_not_nil assigns["current_user"]
  end
end
