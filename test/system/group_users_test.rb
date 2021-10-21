require "application_system_test_case"

class GroupUsersTest < ApplicationSystemTestCase
  setup do
    @group_user = group_users(:one)
  end

  test "visiting the index" do
    visit group_users_url
    assert_selector "h1", text: "Group Users"
  end

  test "creating a Group user" do
    visit group_users_url
    click_on "New Group User"

    fill_in "G", with: @group_user.g_id
    fill_in "Role", with: @group_user.role
    fill_in "U", with: @group_user.u_id
    click_on "Create Group user"

    assert_text "Group user was successfully created"
    click_on "Back"
  end

  test "updating a Group user" do
    visit group_users_url
    click_on "Edit", match: :first

    fill_in "G", with: @group_user.g_id
    fill_in "Role", with: @group_user.role
    fill_in "U", with: @group_user.u_id
    click_on "Update Group user"

    assert_text "Group user was successfully updated"
    click_on "Back"
  end

  test "destroying a Group user" do
    visit group_users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Group user was successfully destroyed"
  end
end
