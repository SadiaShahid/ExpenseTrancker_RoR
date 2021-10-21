require "application_system_test_case"

class GroupPayersTest < ApplicationSystemTestCase
  setup do
    @group_payer = group_payers(:one)
  end

  test "visiting the index" do
    visit group_payers_url
    assert_selector "h1", text: "Group Payers"
  end

  test "creating a Group payer" do
    visit group_payers_url
    click_on "New Group Payer"

    fill_in "Borrow", with: @group_payer.borrow
    fill_in "Group expense", with: @group_payer.group_expense_id
    fill_in "Integer", with: @group_payer.integer
    fill_in "Lent", with: @group_payer.lent
    fill_in "User", with: @group_payer.user_id
    click_on "Create Group payer"

    assert_text "Group payer was successfully created"
    click_on "Back"
  end

  test "updating a Group payer" do
    visit group_payers_url
    click_on "Edit", match: :first

    fill_in "Borrow", with: @group_payer.borrow
    fill_in "Group expense", with: @group_payer.group_expense_id
    fill_in "Integer", with: @group_payer.integer
    fill_in "Lent", with: @group_payer.lent
    fill_in "User", with: @group_payer.user_id
    click_on "Update Group payer"

    assert_text "Group payer was successfully updated"
    click_on "Back"
  end

  test "destroying a Group payer" do
    visit group_payers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Group payer was successfully destroyed"
  end
end
