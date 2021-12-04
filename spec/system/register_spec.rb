require 'rails_helper'

RSpec.describe "Register", type: :system do
  let(:user) { create(:user) }

  describe 'ユーザー登録' do
    context 'フォームの正常に入力されている' do
      it '登録に成功する' do
        visit root_path
        click_on '新規登録', match: :first
        expect(current_path).to eq '/register'
        expect(page).to have_content 'ユーザー登録'
        fill_in '名前', with: 'example'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'pass'
        fill_in 'パスワード確認', with: 'pass'
        click_on '登録'
        sleep 3
        expect(current_path).to eq '/login'
        expect(page).to have_content '登録が完了しました'
      end
    end

    context '名前が未入力' do
      it '登録ボタンが押せなくなっている' do
        visit root_path
        click_on '新規登録', match: :first
        expect(current_path).to eq '/register'
        expect(page).to have_content 'ユーザー登録'
        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'pass'
        fill_in 'パスワード確認', with: 'pass'
        expect(page).to have_content '名前は必須項目です'
        expect(page).to have_button '登録', disabled: true
      end
    end

    context 'メールアドレスが未入力' do
      it '登録ボタンが押せなくなっている' do
        visit root_path
        click_on '新規登録', match: :first
        expect(current_path).to eq '/register'
        expect(page).to have_content 'ユーザー登録'
        fill_in '名前', with: 'example'
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'pass'
        fill_in 'パスワード確認', with: 'pass'
        expect(page).to have_content 'メールアドレスは必須項目です'
        expect(page).to have_button '登録', disabled: true
      end
    end

    context 'パスワードが未入力' do
      it '登録ボタンが押せなくなっている' do
        visit root_path
        click_on '新規登録', match: :first
        expect(current_path).to eq '/register'
        expect(page).to have_content 'ユーザー登録'
        fill_in '名前', with: 'example'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: ''
        fill_in 'パスワード確認', with: 'pass'
        expect(page).to have_content 'パスワードは必須項目です'
        expect(page).to have_button '登録', disabled: true
      end
    end

    context 'パスワード確認が未入力' do
      it '登録ボタンが押せなくなっている' do
        visit root_path
        click_on '新規登録', match: :first
        expect(current_path).to eq '/register'
        expect(page).to have_content 'ユーザー登録'
        fill_in '名前', with: 'example'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'pass'
        fill_in 'パスワード確認', with: ''
        expect(page).to have_content 'パスワード確認は必須項目です'
        expect(page).to have_button '登録', disabled: true
      end
    end

    context '名前が11文字以上' do
      it '登録ボタンが押せなくなっている' do
        visit root_path
        click_on '新規登録', match: :first
        expect(current_path).to eq '/register'
        expect(page).to have_content 'ユーザー登録'
        fill_in '名前', with: 'aaaaaaaaaaa'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'pass'
        fill_in 'パスワード確認', with: 'pass'
        expect(page).to have_content '名前は10文字以下でご入力ください'
        expect(page).to have_button '登録', disabled: true
      end
    end

    context 'メールアドレスの形式で入力されていない' do
      it '登録ボタンが押せなくなっている' do
        visit root_path
        click_on '新規登録', match: :first
        expect(current_path).to eq '/register'
        expect(page).to have_content 'ユーザー登録'
        fill_in '名前', with: 'example'
        fill_in 'メールアドレス', with: 'test'
        fill_in 'パスワード', with: 'pass'
        fill_in 'パスワード確認', with: 'pass'
        expect(page).to have_content 'メールアドレスの形式でご入力ください'
        expect(page).to have_button '登録', disabled: true
      end
    end

    context '登録済みのメールアドレスが入力されている' do
      it '登録ボタンが押せなくなっている' do
        existed_user = create(:user)
        visit root_path
        click_on '新規登録', match: :first
        expect(current_path).to eq '/register'
        expect(page).to have_content 'ユーザー登録'
        fill_in '名前', with: 'example'
        fill_in 'メールアドレス', with: existed_user.email
        fill_in 'パスワード', with: 'pass'
        fill_in 'パスワード確認', with: 'pass'
        expect(page).to have_content 'このメールアドレスは登録済みです'
        expect(page).to have_button '登録', disabled: true
      end
    end

    context 'パスワードとパスワード確認が2文字以下' do
      it '登録ボタンが押せなくなっている' do
        visit root_path
        click_on '新規登録', match: :first
        expect(current_path).to eq '/register'
        expect(page).to have_content 'ユーザー登録'
        fill_in '名前', with: 'example'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'pa'
        fill_in 'パスワード確認', with: 'pa'
        expect(page).to have_content 'パスワードは3文字以上でご入力ください'
        expect(page).to have_content 'パスワード確認は3文字以上でご入力ください'
        expect(page).to have_button '登録', disabled: true
      end
    end

    context 'パスワードとパスワード確認が一致しない' do
      it '登録ボタンが押せなくなっている' do
        visit root_path
        click_on '新規登録', match: :first
        expect(current_path).to eq '/register'
        expect(page).to have_content 'ユーザー登録'
        fill_in '名前', with: 'example'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'pass'
        fill_in 'パスワード確認', with: 'password'
        expect(page).to have_content 'パスワードと一致しません'
        expect(page).to have_button '登録', disabled: true
      end
    end
  end

end
