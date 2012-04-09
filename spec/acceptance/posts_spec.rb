# encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Posts' do

  before do
    @post = Factory(:post)
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

end