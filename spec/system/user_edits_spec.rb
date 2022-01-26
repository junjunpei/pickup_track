require 'rails_helper'

RSpec.describe "UserEdits", type: :system do
  let(:user) { create(:user) }
  before { login_as(user) }

  describe "ユーザー情報編集機能" do
    context "名前を変更する" do
      it "更新に成功し、フラッシュメッセージが表示され、表示されている名前が変更後のものになっている" do
        visit root_path
        find('#user-menu').click
        find('#user-information').click
        expect(current_path).to eq '/user'
        click_on 'ユーザー情報編集'
        expect(page).to have_field '名前', with: user.name
        expect(page).to have_field 'メールアドレス', with: user.email
        fill_in '名前', with: 'other'
        click_on '更新'
        sleep 1
        expect(page).to have_content '更新が完了しました'
        expect(page).to have_field '名前', with: 'other'
      end
    end
  end

  context "メールアドレスを変更する" do
    it "更新に成功し、フラッシュメッセージが表示され、表示されているメールアドレスが変更後のものになっている" do
      visit root_path
      find('#user-menu').click
      find('#user-information').click
      expect(current_path).to eq '/user'
      click_on 'ユーザー情報編集'
      expect(page).to have_field '名前', with: user.name
      expect(page).to have_field 'メールアドレス', with: user.email
      fill_in 'メールアドレス', with: 'other@example.com'
      click_on '更新'
      sleep 1
      expect(page).to have_content '更新が完了しました'
      expect(page).to have_field 'メールアドレス', with: 'other@example.com'
    end
  end

  context "パスワードを変更する" do
    it "更新に成功し、フラッシュメッセージが表示される" do
      visit root_path
      find('#user-menu').click
      find('#user-information').click
      expect(current_path).to eq '/user'
      click_on 'ユーザー情報編集'
      expect(page).to have_field '名前', with: user.name
      expect(page).to have_field 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'other'
      fill_in 'パスワード確認', with: 'other'
      click_on '更新'
      sleep 1
      expect(page).to have_content '更新が完了しました'
    end
  end

  context "名前を未入力にする" do
    it "エラーメッセージが表示され、更新ボタンが押せなくなっている" do
      visit root_path
      find('#user-menu').click
      find('#user-information').click
      expect(current_path).to eq '/user'
      click_on 'ユーザー情報編集'
      expect(page).to have_field '名前', with: user.name
      expect(page).to have_field 'メールアドレス', with: user.email
      fill_in '名前', with: ' '
      expect(page).to have_content '名前は必須項目です'
      expect(page).to have_button '更新', disabled: true
    end
  end

  context "名前を11文字で入力にする" do
    it "エラーメッセージが表示され、更新ボタンが押せなくなっている" do
      visit root_path
      find('#user-menu').click
      find('#user-information').click
      expect(current_path).to eq '/user'
      click_on 'ユーザー情報編集'
      expect(page).to have_field '名前', with: user.name
      expect(page).to have_field 'メールアドレス', with: user.email
      fill_in '名前', with: 'aaaaaaaaaaa'
      expect(page).to have_content '名前は10文字以下でご入力ください'
      expect(page).to have_button '更新', disabled: true
    end
  end

  context "メールアドレスを未入力にする" do
    it "エラーメッセージが表示され、更新ボタンが押せなくなっている" do
      visit root_path
      find('#user-menu').click
      find('#user-information').click
      expect(current_path).to eq '/user'
      click_on 'ユーザー情報編集'
      expect(page).to have_field '名前', with: user.name
      expect(page).to have_field 'メールアドレス', with: user.email
      fill_in 'メールアドレス', with: ' '
      expect(page).to have_content 'メールアドレスは必須項目です'
      expect(page).to have_button '更新', disabled: true
    end
  end

  context "メールアドレスがメールアドレスの形式で入力されていない" do
    it "エラーメッセージが表示され、更新ボタンが押せなくなっている" do
      visit root_path
      find('#user-menu').click
      find('#user-information').click
      expect(current_path).to eq '/user'
      click_on 'ユーザー情報編集'
      expect(page).to have_field '名前', with: user.name
      expect(page).to have_field 'メールアドレス', with: user.email
      fill_in 'メールアドレス', with: 'other'
      sleep 1
      expect(page).to have_content 'メールアドレスの形式でご入力ください'
      expect(page).to have_button '更新', disabled: true
    end
  end

  context "登録済みのメールアドレスが入力されている" do
    it "エラーメッセージが表示され、更新ボタンが押せなくなっている" do
      existed_user = create(:user)
      visit root_path
      find('#user-menu').click
      find('#user-information').click
      expect(current_path).to eq '/user'
      click_on 'ユーザー情報編集'
      expect(page).to have_field '名前', with: user.name
      expect(page).to have_field 'メールアドレス', with: user.email
      fill_in 'メールアドレス', with: existed_user.email
      sleep 2
      expect(page).to have_content 'このメールアドレスは登録済みです'
      expect(page).to have_button '更新', disabled: true
    end
  end

  context "一度メールアドレスのフィールドを空にしてから自分のメールアドレスを入力する" do
    it "登録済みのエラーが出ない" do
      visit root_path
      find('#user-menu').click
      find('#user-information').click
      expect(current_path).to eq '/user'
      click_on 'ユーザー情報編集'
      expect(page).to have_field '名前', with: user.name
      expect(page).to have_field 'メールアドレス', with: user.email
      fill_in 'メールアドレス', with: ''
      fill_in 'メールアドレス', with: user.email
      expect(page).not_to have_content 'このメールアドレスは登録済みです'
      expect(page).to have_button '更新', disabled: false
    end
  end

  context "パスワードとパスワード確認を2文字で入力する" do
    it "エラーメッセージが表示され、更新ボタンが押せなくなっている" do
      visit root_path
      find('#user-menu').click
      find('#user-information').click
      expect(current_path).to eq '/user'
      click_on 'ユーザー情報編集'
      expect(page).to have_field '名前', with: user.name
      expect(page).to have_field 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'pa'
      fill_in 'パスワード確認', with: 'pa'
      expect(page).to have_content 'パスワードは3文字以上でご入力ください'
      expect(page).to have_content 'パスワード確認は3文字以上でご入力ください'
      expect(page).to have_button '更新', disabled: true
    end
  end

  context "パスワードとパスワード確認が一致していない" do
    it "エラーメッセージが表示され、更新ボタンが押せなくなっている" do
      visit root_path
      find('#user-menu').click
      find('#user-information').click
      expect(current_path).to eq '/user'
      click_on 'ユーザー情報編集'
      expect(page).to have_field '名前', with: user.name
      expect(page).to have_field 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'pass'
      fill_in 'パスワード確認', with: 'other'
      expect(page).to have_content 'パスワードと一致しません'
      expect(page).to have_button '更新', disabled: true
    end
  end
end
