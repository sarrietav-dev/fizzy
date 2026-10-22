require "test_helper"

class Users::PermissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as :kevin
  end

  test "update" do
    assert users(:david).can_create_board?

    put user_permission_path(users(:david)), params: { user: { can_create_boards: "0" } }

    assert_redirected_to account_settings_path
    assert_not users(:david).reload.can_create_board?
  end

  test "update as JSON" do
    put user_permission_path(users(:david)), params: { user: { can_create_boards: false } }, as: :json

    assert_response :no_content
    assert_not users(:david).reload.can_create_board?
  end

  test "permission is offered in the account settings" do
    get account_settings_path

    assert_response :success
    assert_select "input[name=?]", "user[can_create_boards]"
  end

  test "members cannot change permissions" do
    logout_and_sign_in_as :david

    put user_permission_path(users(:jz)), params: { user: { can_create_boards: "0" } }

    assert_response :forbidden
    assert users(:jz).reload.can_create_board?
  end

  test "cannot change the owner's permissions" do
    put user_permission_path(users(:jason)), params: { user: { can_create_boards: "0" } }

    assert_response :forbidden
    assert users(:jason).reload.can_create_board?
  end
end
