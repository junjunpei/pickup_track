require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン' do
    context 'フォームが正常に入力されている' do
      it 'ログインに成功する' do
        visit root_path
        click_on 'ログイン'
        expect(current_path).to eq '/login'
        expect(page).to have_content 'ログイン'
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'pass'
        find('#login').click
        sleep 3
        expect(page).to have_content 'ログインしました'
        expect(page).to have_content '楽曲検索'
        expect(page).to have_content 'マイライブラリ'
        expect(page).to have_content 'ユーザー情報'
        expect(page).to have_content 'ログアウト'
        expect(page).not_to have_content 'ログイン'
        expect(current_path).to eq root_path
      end
    end

    context 'メールアドレスが入力されていない' do
      it 'ログインボタンが押せなくなっている' do
        visit root_path
        click_on 'ログイン'
        expect(current_path).to eq '/login'
        expect(page).to have_content 'ログイン'
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'pass'
        expect(page).to have_content 'メールアドレスは必須項目です'
        expect(page).to have_button 'ログイン', disabled: true
      end
    end

    context 'メールアドレスの形式で入力されていない' do
      it 'ログインボタンが押せなくなっている' do
        visit root_path
        click_on 'ログイン'
        expect(current_path).to eq '/login'
        expect(page).to have_content 'ログイン'
        fill_in 'メールアドレス', with: 'email'
        fill_in 'パスワード', with: 'pass'
        expect(page).to have_content 'メールアドレスの形式でご入力ください'
        expect(page).to have_button 'ログイン', disabled: true
      end
    end

    context 'パスワードが入力されていない' do
      it 'ログインボタンが押せなくなっている' do
        visit root_path
        click_on 'ログイン'
        expect(current_path).to eq '/login'
        expect(page).to have_content 'ログイン'
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: ''
        expect(page).to have_content 'パスワードは必須項目です'
        expect(page).to have_button 'ログイン', disabled: true
      end
    end

    context 'パスワードが3文字未満で入力されている' do
      it 'ログインボタンが押せなくなっている' do
        visit root_path
        click_on 'ログイン'
        expect(current_path).to eq '/login'
        expect(page).to have_content 'ログイン'
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'pa'
        expect(page).to have_content 'パスワードは3文字以上でご入力ください'
        expect(page).to have_button 'ログイン', disabled: true
      end
    end

    context 'メールアドレスが間違っている' do
      it 'ログインに失敗する' do
        visit root_path
        click_on 'ログイン'
        expect(current_path).to eq '/login'
        expect(page).to have_content 'ログイン'
        fill_in 'メールアドレス', with: 'foobar@example.com'
        fill_in 'パスワード', with: 'pass'
        find('#login').click
        sleep 3
        expect(page).to have_content 'メールアドレス、またはパスワードが間違っています'
        expect(current_path).to eq '/login'
      end
    end

    context 'パスワードが間違っている' do
      it 'ログインに失敗する' do
        visit root_path
        click_on 'ログイン'
        expect(current_path).to eq '/login'
        expect(page).to have_content 'ログイン'
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        find('#login').click
        sleep 3
        expect(page).to have_content 'メールアドレス、またはパスワードが間違っています'
        expect(current_path).to eq '/login'
      end
    end
  end

  describe 'ログアウト' do
    context "ログアウトボタンを押す" do
      it 'ログアウトに成功する' do
        visit root_path
        click_on 'ログイン'
        expect(current_path).to eq '/login'
        expect(page).to have_content 'ログイン'
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'pass'
        find('#login').click
        sleep 3
        expect(page).to have_content 'ログインしました'
        expect(page).to have_content '楽曲検索'
        expect(page).to have_content 'マイライブラリ'
        expect(page).to have_content 'ユーザー情報'
        expect(page).to have_content 'ログアウト'
        click_on 'ログアウト'
        sleep 2
        expect(page).to have_content 'ログアウトしました'
        expect(current_path).to eq root_path
      end
    end

  end
end
