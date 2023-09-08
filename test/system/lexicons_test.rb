require "application_system_test_case"

class LexiconsTest < ApplicationSystemTestCase
  setup do
    @lexicon = lexicons(:one)
  end

  test "visiting the index" do
    visit lexicons_url
    assert_selector "h1", text: "Lexicons"
  end

  test "should create lexicon" do
    visit lexicons_url
    click_on "New lexicon"

    check "Active" if @lexicon.active
    fill_in "Lang", with: @lexicon.lang
    fill_in "User", with: @lexicon.user_id
    fill_in "Word", with: @lexicon.word
    fill_in "Wordhu", with: @lexicon.wordhu
    click_on "Create Lexicon"

    assert_text "Lexicon was successfully created"
    click_on "Back"
  end

  test "should update Lexicon" do
    visit lexicon_url(@lexicon)
    click_on "Edit this lexicon", match: :first

    check "Active" if @lexicon.active
    fill_in "Lang", with: @lexicon.lang
    fill_in "User", with: @lexicon.user_id
    fill_in "Word", with: @lexicon.word
    fill_in "Wordhu", with: @lexicon.wordhu
    click_on "Update Lexicon"

    assert_text "Lexicon was successfully updated"
    click_on "Back"
  end

  test "should destroy Lexicon" do
    visit lexicon_url(@lexicon)
    click_on "Destroy this lexicon", match: :first

    assert_text "Lexicon was successfully destroyed"
  end
end
