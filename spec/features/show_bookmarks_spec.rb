feature 'Viewing bookmarks' do
  scenario 'shows a list of bookmarks' do
    visit '/bookmarks'
    expect(page).to have_content "Google"
    expect(page).to have_content "Youtube"
  end
end
