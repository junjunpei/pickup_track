require 'rails_helper'

RSpec.describe "PasswordResets", type: :system do
  let(:user) { create(:user) }

  describe 'パスワード再設定機能' do
    context '登録されているメールアドレスを入力する' do
      it 'メールを送信しましたというフラッシュメッセージが表示され、パスワード再設定が成功する' do
        visit '/login'
        click_on 'パスワードをお忘れの方'
        fill_in 'password-reset-mail', with: user.email
        click_on '送信する'
        sleep 2
        expect(page).to have_content 'メールを送信しました'
        @user = User.find_by(email: user.email)
        visit "/reset_password/path?id=#{@user.reset_password_token}"
        expect(page).to have_button '更新', disabled: true
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_on '更新'
        sleep 2
        expect(current_path).to eq '/login'
        expect(page).to have_content 'パスワードを変更しました'
      end
    end

    context '登録されていないメールアドレスを入力する' do
      it 'メールを送信しましたというフラッシュメッセージが表示されるが、reset_password_tokenが生成されていない' do
        visit '/login'
        click_on 'パスワードをお忘れの方'
        fill_in 'password-reset-mail', with: 'foobar@example.com'
        click_on '送信する'
        sleep 2
        expect(page).to have_content 'メールを送信しました'
        @user = User.find_by(email: user.email)
        expect(@user.reset_password_token).to be nil
      end
    end
  end
end
