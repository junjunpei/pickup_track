require 'rails_helper'

RSpec.describe "PickupTracks", type: :system do
  let(:user) { create(:user) }
  before { login_as(user) }
  before { track_create(ENV['SEARCH_TRACK_NAME']) }
  before { track_create(ENV['SEARCH_TRACK_NAME2']) }
  before { track_create(ENV['SEARCH_TRACK_NAME3']) }

  describe "楽曲ピックアップ機能" do
    context '検索フィールドの上のピックアップボタンを押す' do
      it 'ピックアップに成功し、楽曲情報のモーダルが表示される' do
        visit '/mylibrary'
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME2']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME2']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME2']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME3']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME3']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME3']
        expect(find('#my-library-list')).to have_selector '#delete-icon', count: 3
        expect(page).to have_button 'ピックアップ'
        click_on 'ピックアップ'
        sleep 1
        expect(page).to have_content '結果'
        expect(page).to have_button 'もう一度！'
        expect(page).to have_button 'この曲を歌う'
      end
    end

    context 'スクロールする' do
      before { track_create(ENV['SEARCH_TRACK_NAME4'])}
      before { track_create(ENV['SEARCH_TRACK_NAME5'])}
      before { track_create(ENV['SEARCH_TRACK_NAME6'])}
      before { track_create(ENV['SEARCH_TRACK_NAME7'])}
      before { track_create(ENV['SEARCH_TRACK_NAME8'])}
      before { track_create(ENV['SEARCH_TRACK_NAME9'])}
      before { track_create(ENV['SEARCH_TRACK_NAME10'])}
      before { track_create(ENV['SEARCH_TRACK_NAME11'])}
      before { track_create(ENV['SEARCH_TRACK_NAME12'])}
      before { track_create(ENV['SEARCH_TRACK_NAME13'])}
      before { track_create(ENV['SEARCH_TRACK_NAME14'])}
      before { track_create(ENV['SEARCH_TRACK_NAME15'])}
      before { track_create(ENV['SEARCH_TRACK_NAME16'])}
      before { track_create(ENV['SEARCH_TRACK_NAME17'])}
      before { track_create(ENV['SEARCH_TRACK_NAME18'])}
      before { track_create(ENV['SEARCH_TRACK_NAME19'])}
      before { track_create(ENV['SEARCH_TRACK_NAME20'])}

      it 'fabが表示され、押すとピックアップに成功する' do
        visit '/mylibrary'
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME2']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME3']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME4']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME5']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME6']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME7']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME8']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME9']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME10']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME11']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME12']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME13']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME14']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME15']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME16']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME17']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME18']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME19']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME20']
        expect(find('#my-library-list')).to have_selector '#delete-icon', count: 20
        expect(page).to have_button 'ピックアップ'
        expect(page).not_to have_selector '#pickup-fab'
        page.execute_script('window.scroll(0, 300)')
        expect(page).to have_selector '#pickup-fab'
        find('#pickup-fab').click
        sleep 1
        expect(page).to have_content '結果'
        expect(page).to have_button 'もう一度！'
        expect(page).to have_button 'この曲を歌う'
      end
    end

    context '検索をしてからピックアップボタンを押す' do
      it '検索結果からピックアップされる' do
        visit '/mylibrary'
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME2']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME2']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME2']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME3']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME3']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME3']
        expect(find('#my-library-list')).to have_selector '#delete-icon', count: 3
        fill_in 'Search', with: ENV['SEARCH_TRACK_NAME']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_NAME']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME']
        expect(find('#my-library-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME']
        expect(find('#my-library-list')).not_to have_content ENV['SEARCH_TRACK_NAME2']
        expect(find('#my-library-list')).not_to have_content ENV['SEARCH_TRACK_ARTIST_NAME2']
        expect(find('#my-library-list')).not_to have_content ENV['SEARCH_TRACK_ALBUM_NAME2']
        expect(find('#my-library-list')).not_to have_content ENV['SEARCH_TRACK_NAME3']
        expect(find('#my-library-list')).not_to have_content ENV['SEARCH_TRACK_ARTIST_NAME3']
        expect(find('#my-library-list')).not_to have_content ENV['SEARCH_TRACK_ALBUM_NAME3']
        expect(find('#my-library-list')).to have_selector '#delete-icon', count: 1
        expect(page).to have_button 'ピックアップ'
        click_on 'ピックアップ'
        sleep 1
        expect(page).to have_content '結果'
        expect(page).to have_button 'もう一度！'
        expect(page).to have_button 'この曲を歌う'
        expect(page).to have_content ENV['SEARCH_TRACK_NAME'], count: 2
        expect(page).to have_content ENV['SEARCH_TRACK_ARTIST_NAME'], count: 2
        expect(page).to have_content ENV['SEARCH_TRACK_ALBUM_NAME'], count: 2
        click_on 'もう一度！'
        expect(page).to have_content '結果'
        expect(page).to have_button 'もう一度！'
        expect(page).to have_button 'この曲を歌う'
        expect(page).to have_content ENV['SEARCH_TRACK_NAME'], count: 2
        expect(page).to have_content ENV['SEARCH_TRACK_ARTIST_NAME'], count: 2
        expect(page).to have_content ENV['SEARCH_TRACK_ALBUM_NAME'], count: 2
      end
    end
  end

end
