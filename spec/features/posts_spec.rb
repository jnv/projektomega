# encoding: utf-8
require 'features/features_helper'

feature 'Posts' do

  before do
    @post = FactoryGirl.create(:post)
    @character = @post.character
    @user = @character.user
  end

  scenario "show posts" do
    visit posts_path
    page.should have_no_link("Nový příspěvek")

    within(css_dom_id(@post)) do
      page.should have_link(@character.full_name)
      page.should have_content(@post.content)
      page.should have_no_link("Upravit")
    end
  end

  describe "user with character" do
    before do
      sign_in_with @user
      visit posts_path
    end

    scenario "creates new post" do
      click_link "Nový příspěvek"

      fill_in 'Text', with: "blahblah"
      click_button "Vytvořit"
      page.should have_content "blahblah"
    end

    scenario "edits own post" do
      within(css_dom_id(@post)) do
        click_link "Upravit"
      end
      fill_in 'Text', with: "blahblah"
      click_button "Uložit změny"
      within(css_dom_id(@post)) do
        page.should have_content "blahblah"
      end
    end
  end

  describe "user without character" do
    before do
      sign_in_with FactoryGirl.create(:user)
      visit posts_path
    end

    scenario "shouldn't be allowed to create a post" do
      within("#posts") do
        page.should have_no_link("Nový příspěvek")
        page.should have_no_link("Upravit")
      end

      visit new_post_path
      access_should_be_denied
    end
  end


end
