require 'rails_helper'

RSpec.describe "SearchTracks", type: :system do
  let(:user) { create(:user) }
  before { login_as(user) }

  describe '楽曲を検索' do
    context '検索ワードが正常に入力されている' do
      it '楽曲検索が成功し、ページネーションが表示される' do
        visit root_path
        click_on '楽曲検索'
        expect(current_path).to eq '/search'
        expect(page).not_to have_selector '.v-pagination'
        fill_in 'Search', with: ENV['SEARCH_TRACK_NAME']
        click_on '検索'
        expect(page).to have_button '検索', disabled: true
        expect(find('#search-tracks-list')).to have_content ENV['SEARCH_TRACK_NAME']
        expect(find('#search-tracks-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME']
        expect(find('#search-tracks-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME']
        expect(find('#search-tracks-list')).to have_selector '#create-icon'
        expect(page).to have_selector '.v-pagination'
      end
    end

    context '検索ワードが入力されていない' do
      it '検索ボタンが押せなくなっている' do
        visit root_path
        click_on '楽曲検索'
        expect(current_path).to eq '/search'
        fill_in 'Search', with: ''
        expect(page).to have_button '検索', disabled: true
      end
    end

    context 'どの曲にも該当しないワードが入力されている' do
      it '「検索結果がありません」というフラッシュメッセージが出る' do
        visit root_path
        click_on '楽曲検索'
        expect(current_path).to eq '/search'
        fill_in 'Search', with: 'agohowhgowhigwghwio'
        click_on '検索'
        sleep 3
        expect(page).to have_content '検索結果がありません'
      end
    end
  end
end
