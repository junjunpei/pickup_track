require 'rails_helper'

RSpec.describe "UserInformations", type: :system do
  let(:user) { create(:user) }
  before { login_as(user) }
  before { track_create(ENV['SEARCH_TRACK_NAME']) }

  describe 'ユーザー情報画面' do
    context 'マイライブラリでピックアップした曲で「この曲を歌う！」を選択する' do
      it '「この曲を歌う！」を選択した楽曲が履歴として表示されていて、回数が多い順に並び替えると曲ごと子回数が表示されている' do
        visit '/mylibrary'
        click_on 'ピックアップ'
        sleep 2
        click_on 'この曲を歌う！'
        click_on 'ピックアップ'
        sleep 2
        click_on 'この曲を歌う！'
        visit '/user'
        expect(page).to have_content '名前'
        expect(page).to have_content user.name
        expect(page).to have_content 'メールアドレス'
        expect(page).to have_content user.email
        expect(page).to have_content '今までに歌った回数'
        expect(page).to have_content '2回', count: 1
        expect(page)  .to have_content '歌った履歴'
        expect(page).to have_content '新着順'
        expect(page).to have_selector '#order-status'
        expect(find('#history-list')).to have_content ENV['SEARCH_TRACK_NAME'], count: 2
        expect(find('#history-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME'], count: 2
        expect(find('#history-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME'], count: 2
        find('.v-select').click
        find('.v-list-item__title', text: '回数が多い順').click
        expect(find('#history-list')).to have_content ENV['SEARCH_TRACK_NAME'], count: 1
        expect(find('#history-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME'], count: 1
        expect(find('#history-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME'], count: 1
        expect(page).to have_content '2回', count: 2
      end
    end

    context '歌った履歴のゴミ箱ボタンを押す' do
      it '履歴が削除される' do
        visit '/mylibrary'
        click_on 'ピックアップ'
        sleep 2
        click_on 'この曲を歌う！'
        click_on 'ピックアップ'
        sleep 2
        click_on 'この曲を歌う！'
        visit '/user'
        expect(page).to have_content '名前'
        expect(page).to have_content user.name
        expect(page).to have_content 'メールアドレス'
        expect(page).to have_content user.email
        expect(page).to have_content '今までに歌った回数'
        expect(page).to have_content '2回', count: 1
        expect(page)  .to have_content '歌った履歴'
        expect(page).to have_content '新着順'
        expect(page).to have_selector '#order-status'
        expect(find('#history-list')).to have_content ENV['SEARCH_TRACK_NAME'], count: 2
        expect(find('#history-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME'], count: 2
        expect(find('#history-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME'], count: 2
        first('#delete-history-icon').click
        sleep 2
        expect(page).to have_content '履歴から削除されました'
        expect(find('#history-list')).to have_content ENV['SEARCH_TRACK_NAME'], count: 1
        expect(find('#history-list')).to have_content ENV['SEARCH_TRACK_ARTIST_NAME'], count: 1
        expect(find('#history-list')).to have_content ENV['SEARCH_TRACK_ALBUM_NAME'], count: 1
        find('.v-select').click
        find('.v-list-item__title', text: '回数が多い順').click
        expect(page).to have_content '1回', count: 2
      end
    end
  end

end
