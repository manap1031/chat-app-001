require 'rails_helper'

RSpec.describe "ユーザログイン機能", type: :system do
  it "ログインしていない場合、サインページに移動する" do
    # トップページに遷移する。
    visit root_path

    #ログインしていない場合は、サインページに遷移することを期待する。
    expect(current_path).to eq new_user_session_path
  end

  it "ログインに成功し、ルートパスに遷移する" do
    #予め、ユーザーをDBに保存する。
    @user = FactoryBot.create(:user)

    #サインページへ移動する。
    visit new_user_session_path

    #ログインしていない場合は、サインページに遷移することを期待する。
    expect(current_path).to eq new_user_session_path

    #既に保存されているユーザーのemailとpasswordを入力する。
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: @user.password

    #ログインボタンをクリックする。
    click_on("Log in")

    #ルートページに遷移することを期待する。
    expect(current_path).to eq root_path
  end
  it "ログインに失敗し、再びサインページに戻ってくる" do
    #予め、ユーザーをDBに保存する。
    @user = FactoryBot.create(:user)

    #トップページに遷移する。
    visit root_path

    #ログインしていない場合、サインページに遷移することを期待する。
    expect(current_path).to eq new_user_session_path

    #誤ったユーザー情報を入力する。
    fill_in "user_email", with: "hogehoge"
    fill_in "user_password", with: "hogehoge@test.com"

    #ログインボタンをクリックする。
    click_on("Log in")

    #サインページに遷移していることを期待する。
    expect(current_path).to eq new_user_session_path
  end
end
