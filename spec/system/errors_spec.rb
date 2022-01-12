require 'rails_helper'

RSpec.describe "Errors", type: :system do

  describe 'エラーページ' do
    context '存在しないURLにアクセス' do
      it '404ページに遷移される' do
        visit '/register/foobar'
        expect(page).to have_content 'ページが見つかりませんでした'
      end
    end

    context '例外を発生させ、そのページにアクセスする' do
      it '500ページに遷移される' do
        visit '/error'
        expect(page).to have_content 'サーバーエラーが発生しました'
        expect(page).to have_content '申し訳ございませんが、少し時間をおいてから再度お試しください'
      end
    end
  end
end
