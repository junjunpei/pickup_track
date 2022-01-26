require 'rails_helper'

RSpec.describe "CreateDeleteTracks", type: :system do
  let(:user) { create(:user) }
  before { login_as(user) }

  describe "検索画面" do
    context "曲を追加" do
      it '正常に追加され、ゴミ箱アイコンに変わり、マイライブラリに表示される' do
        visit "/search"
        fill_in 'Search', with: ENV['SEARCH_TRACK_NAME']
        click_on '検索'
        sleep 2
        first('#create-icon').click
        sleep 1
        expect(page).to have_content 'マイライブラリに追加しました'
        expect(find('#tracks-list')).to have_selector '#delete-icon'
        find('#user-menu').click
        click_on 'マイライブラリ'
        expect(current_path).to eq '/mylibrary'
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_NAME']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME']
      end
    end

    context '曲を追加し削除する' do
      it '正常に削除され、プラスアイコンに変わり、マイライブラリに表示されていない' do
        visit "/search"
        fill_in 'Search', with: ENV['SEARCH_TRACK_NAME']
        click_on '検索'
        first('#create-icon').click
        sleep 1
        expect(page).to have_content 'マイライブラリに追加しました'
        expect(find('#tracks-list')).to have_selector '#delete-icon'
        first('#delete-icon').click
        sleep 1
        expect(page).to have_content 'マイライブラリから削除しました'
        expect(find('#tracks-list')).to have_selector '#create-icon'
        find('#user-menu').click
        click_on 'マイライブラリ'
        expect(current_path).to eq '/mylibrary'
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_NAME']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_ARTIST_NAME']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_ALBUM_NAME']
      end
    end
  end

  describe "マイライブラリ画面" do
    before { track_create(ENV['SEARCH_TRACK_NAME']) }

    context '表示されている曲を削除する' do
      it '正常に削除され、プラスアイコンに変わり、その曲が表示されていない' do
        visit "/mylibrary"
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_NAME']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME']
        expect(find('#tracks-list')).to have_selector '#delete-icon'
        find('#delete-icon').click
        sleep 1
        expect(page).to have_content 'マイライブラリから削除しました'
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_NAME']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_ARTIST_NAME']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_ALBUM_NAME']
      end
    end

    context '表示されている曲を曲名でリアルタイム検索をする' do
      before { track_create(ENV['SEARCH_TRACK_NAME2']) }
      before { track_create(ENV['SEARCH_TRACK_NAME3']) }

      it '検索された曲のみが表示されている' do
        visit "/mylibrary"
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_NAME']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_NAME2']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME2']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME2']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_NAME3']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME3']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME3']
        expect(find('#tracks-list')).to have_selector '#delete-icon', count: 3
        fill_in 'Search', with: ENV['SEARCH_TRACK_NAME']
        sleep 1
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_NAME']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_NAME2']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_ARTIST_NAME2']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_ALBUM_NAME2']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_NAME3']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_ARTIST_NAME3']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_ALBUM_NAME3']
      end
    end

    context '表示されている曲をアーティスト名でリアルタイム検索をする' do
      before { track_create(ENV['SEARCH_TRACK_NAME2']) }
      before { track_create(ENV['SEARCH_TRACK_NAME3']) }

      it '検索された曲のみが表示されている' do
        visit "/mylibrary"
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_NAME']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_NAME2']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME2']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME2']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_NAME3']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME3']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME3']
        expect(find('#tracks-list')).to have_selector '#delete-icon', count: 3
        fill_in 'Search', with: ENV['SEARCH_TRACK_ARTIST_NAME2']
        sleep 1
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_NAME2']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME2']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME2']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_NAME']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_ARTIST_NAME']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_ALBUM_NAME']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_NAME3']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_ARTIST_NAME3']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_ALBUM_NAME3']
      end
    end

    context '表示されている曲をアルバム名でリアルタイム検索をする' do
      before { track_create(ENV['SEARCH_TRACK_NAME2']) }
      before { track_create(ENV['SEARCH_TRACK_NAME3']) }

      it '検索された曲のみが表示されている' do
        visit "/mylibrary"
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_NAME']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_NAME2']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME2']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME2']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_NAME3']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME3']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME3']
        expect(find('#tracks-list')).to have_selector '#delete-icon', count: 3
        fill_in 'Search', with: ENV['SEARCH_TRACK_ALBUM_NAME3']
        sleep 1
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_NAME3']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME3']
        expect(find('#tracks-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME3']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_NAME2']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_ARTIST_NAME2']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_ALBUM_NAME2']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_NAME']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_ARTIST_NAME']
        expect(find('#tracks-list')).not_to have_content ENV['SEARCH_TRACK_ALBUM_NAME']
      end
    end
  end

end
