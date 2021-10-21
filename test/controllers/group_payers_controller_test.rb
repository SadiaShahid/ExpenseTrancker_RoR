require "test_helper"

class GroupPayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_payer = group_payers(:one)
  end

  test "should get index" do
    get group_payers_url
    assert_response :success
  end

  test "should get new" do
    get new_group_payer_url
    assert_response :success
  end

  test "should create group_payer" do
    assert_difference('GroupPayer.count') do
      post group_payers_url, params: { group_payer: { borrow: @group_payer.borrow, group_expense_id: @group_payer.group_expense_id, integer: @group_payer.integer, lent: @group_payer.lent, user_id: @group_payer.user_id } }
    end

    assert_redirected_to group_payer_url(GroupPayer.last)
  end

  test "should show group_payer" do
    get group_payer_url(@group_payer)
    assert_response :success
  end

  test "should get edit" do
    get edit_group_payer_url(@group_payer)
    assert_response :success
  end

  test "should update group_payer" do
    patch group_payer_url(@group_payer), params: { group_payer: { borrow: @group_payer.borrow, group_expense_id: @group_payer.group_expense_id, integer: @group_payer.integer, lent: @group_payer.lent, user_id: @group_payer.user_id } }
    assert_redirected_to group_payer_url(@group_payer)
  end

  test "should destroy group_payer" do
    assert_difference('GroupPayer.count', -1) do
      delete group_payer_url(@group_payer)
    end

    assert_redirected_to group_payers_url
  end
end
