require 'rails_helper'

RSpec.describe "UserLeaves", type: :system do
  let(:user) { create(:user) }
  before { login_as(user) }

  describe '退会機能' do
    context 'ユーザー編集画面から退会モーダルを開き、退会する' do
      it '退会に成功し、フラッシュメッセージが表示され、ログインしようとしてもできなくなっている' do
        visit '/user/edit'
        click_on '退会する'
        expect(page).to have_unchecked_field '上記の注意事項に同意する。', visible: false
        expect(page).to have_button 'キャンセル'
        expect(page).to have_button '退会', disabled: true
        check '上記の注意事項に同意する。', allow_label_click: true
        expect(page).to have_checked_field '上記の注意事項に同意する。', visible: false
        expect(page).to have_button '退会'
        click_on '退会'
        sleep 1
        expect(current_path).to eq root_path
        expect(page).to have_content '退会しました、ご利用ありがとうございました'
        click_on 'ログイン'
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'pass'
        find('#login').click
        expect(page).to have_content 'メールアドレス、またはパスワードが間違っています'
        expect(current_path).to eq '/login'
      end
    end

    context 'ユーザー編集画面から退会モーダルを開き、キャンセルボタンを押す' do
      it '退会モーダルが閉じる' do
        visit '/user/edit'
        click_on '退会する'
        expect(page).to have_unchecked_field '上記の注意事項に同意する。', visible: false
        expect(page).to have_button 'キャンセル'
        expect(page).to have_button '退会', disabled: true
        click_on 'キャンセル'
        sleep 1
        expect(page).not_to have_unchecked_field '上記の注意事項に同意する。'
        expect(page).not_to have_button 'キャンセル'
        expect(page).not_to have_button '退会', disabled: true
      end
    end

    context 'ユーザー編集画面から退会モーダルを開き、チェックボックスをチェックした後チェックを外す' do
      it '退会ボタンが押せなくなる' do
        visit '/user/edit'
        click_on '退会する'
        expect(page).to have_unchecked_field '上記の注意事項に同意する。', visible: false
        expect(page).to have_button 'キャンセル'
        expect(page).to have_button '退会', disabled: true
        check '上記の注意事項に同意する。', allow_label_click: true
        expect(page).to have_checked_field '上記の注意事項に同意する。', visible: false
        expect(page).to have_button '退会'
        uncheck '上記の注意事項に同意する', allow_label_click: true
        expect(page).to have_unchecked_field '上記の注意事項に同意する。', visible: false
        expect(page).to have_button '退会', disabled: true
      end
    end
  end

end
