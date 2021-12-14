module TrackSupport
  def track_create(track_name)
    visit "/search"
    fill_in 'Search', with: track_name
    click_on '検索'
    first('#create-icon').click
    sleep 3
    expect(page).to have_content 'マイライブラリに追加しました'
  end
end