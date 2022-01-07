require 'rails_helper'

RSpec.describe "Contacts", type: :system do
  describe 'お問い合わせ機能' do
    context '全ての項目を正しく入力する' do
      it 'お問い合わせが成功する' do
        visit root_path
        click_on 'お問い合わせ'
        expect(current_path).to eq '/contact'
        fill_in 'メールアドレス（任意）', with: 'foobar@example.com'
        fill_in 'お問い合わせの種類（必須）', with: 'バグ、不具合'
        fill_in 'お問い合わせ内容（必須）', with: 'お問い合わせ'
        click_on '送信'
        sleep 2
        expect(page).to have_content 'お問い合わせが完了しました'
        expect(current_path).to eq '/'
      end
    end

    context 'メールアドレスを入力しない' do
      it 'お問い合わせが成功する' do
        visit root_path
        click_on 'お問い合わせ'
        expect(current_path).to eq '/contact'
        fill_in 'お問い合わせの種類（必須）', with: 'バグ、不具合'
        fill_in 'お問い合わせ内容（必須）', with: 'お問い合わせ'
        click_on '送信'
        sleep 2
        expect(page).to have_content 'お問い合わせが完了しました'
        expect(current_path).to eq '/'
      end
    end

    context 'お問い合わせの種類を選択しない' do
      it '送信ボタンが押せない' do
        visit root_path
        click_on 'お問い合わせ'
        expect(current_path).to eq '/contact'
        fill_in 'メールアドレス（任意）', with: 'foobar@example.com'
        fill_in 'お問い合わせ内容（必須）', with: 'お問い合わせ'
        expect(page).to have_button '送信', disabled: true
      end
    end

    context 'お問い合わせ内容を選択しない' do
      it '送信ボタンが押せない' do
        visit root_path
        click_on 'お問い合わせ'
        expect(current_path).to eq '/contact'
        fill_in 'メールアドレス（任意）', with: 'foobar@example.com'
        fill_in 'お問い合わせの種類（必須）', with: 'バグ、不具合'
        expect(page).to have_button '送信', disabled: true
      end
    end

    context 'お問い合わせ内容を1001文字入力する' do
      it '送信ボタンが押せない' do
        visit root_path
        click_on 'お問い合わせ'
        expect(current_path).to eq '/contact'
        fill_in 'メールアドレス（任意）', with: 'foobar@example.com'
        fill_in 'お問い合わせの種類（必須）', with: 'バグ、不具合'
        fill_in 'お問い合わせ内容（必須）', with: 'あ'*1001
        expect(page).to have_button '送信', disabled: true
      end
    end
  end
end
