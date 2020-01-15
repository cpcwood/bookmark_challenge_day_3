feature 'Adding Bookmarks' do
  scenario 'adds bookmark to list' do
    visit '/bookmarks'
    fill_in('url', with: 'http://www.testsite.com')
    click_button('Add Bookmark')
    expect(page).to have_content 'http://www.testsite.com'
  end
end
