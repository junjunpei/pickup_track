module LoginSupport
  def login_as(user)
    visit root_path
    click_on 'ログイン'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'pass'
    find('#login').click
  end
end