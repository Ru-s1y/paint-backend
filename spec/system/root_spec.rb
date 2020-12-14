require 'rails_helper'

RSpec.describe 'Root', type: :system do
  it 'show greeting' do
    # root_pathへアクセス
    visit root_path
    # ページ内に「It's working」が表示されてるか検証
    expect(page).to have_content "It's working"
  end
end