require "application_system_test_case"

class LinesTest < ApplicationSystemTestCase
  setup do
    @line = lines(:one)
  end

  test "visiting the index" do
    visit lines_url
    assert_selector "h1", text: "Lines"
  end

  test "should create line" do
    visit lines_url
    click_on "New line"

    check "Active" if @line.active
    fill_in "Content", with: @line.content
    fill_in "Contentuid", with: @line.contentuid
    fill_in "Datatype", with: @line.datatype
    fill_in "Game", with: @line.game_id
    fill_in "Lang", with: @line.lang
    fill_in "Linieref", with: @line.linieref
    fill_in "Uploadtype", with: @line.uploadtype
    fill_in "User", with: @line.user_id
    fill_in "Version", with: @line.version
    click_on "Create Line"

    assert_text "Line was successfully created"
    click_on "Back"
  end

  test "should update Line" do
    visit line_url(@line)
    click_on "Edit this line", match: :first

    check "Active" if @line.active
    fill_in "Content", with: @line.content
    fill_in "Contentuid", with: @line.contentuid
    fill_in "Datatype", with: @line.datatype
    fill_in "Game", with: @line.game_id
    fill_in "Lang", with: @line.lang
    fill_in "Linieref", with: @line.linieref
    fill_in "Uploadtype", with: @line.uploadtype
    fill_in "User", with: @line.user_id
    fill_in "Version", with: @line.version
    click_on "Update Line"

    assert_text "Line was successfully updated"
    click_on "Back"
  end

  test "should destroy Line" do
    visit line_url(@line)
    click_on "Destroy this line", match: :first

    assert_text "Line was successfully destroyed"
  end
end
