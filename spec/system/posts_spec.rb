require 'rails_helper'

RSpec.describe '投稿', type: :system do
  let!(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:post_by_others) { create(:post) }

  describe '投稿のCRUD' do
    describe '投稿一覧表示' do
      context 'ログインしていない場合' do
        it 'ボタンから投稿一覧へ遷移できること' do
          visit posts_path
          click_on('みんなの投稿を見る')
          expect(current_path).to eq(posts_path), 'ヘッダーのリンクから投稿一覧画面へ遷移できません'
        end
      end

      context 'ログインしている場合' do
        before {login_as(user)}

        it 'ボタンから投稿一覧へ遷移できること' do
          click_on('みんなの投稿を見る')
          expect(current_path).to eq(posts_path), 'ヘッダーのリンクから投稿一覧画面へ遷移できません'
        end

        context '投稿が一件もない場合' do
          before {login_as(user)}
          it '何もない旨のメッセージが表示されること' do
            visit posts_path
            expect(page).to have_content('飯投稿がありません'), '投稿が一件もない場合、「飯投稿がありません」というメッセージが表示されていません'
          end
        end

        context '投稿がある場合' do
          before {login_as(user)}
          it '投稿の一覧が表示されること' do
            post
            visit posts_path
            expect(page).to have_content(post.title), '投稿一覧画面に投稿のタイトルが表示されていません'
            expect(page).to have_content(post.user.name), '投稿一覧画面に投稿者の名前が表示されていません'
          end
        end
      end
    end

    describe '投稿新規登録' do
      context 'フォームの入力値が正常' do
        before {login_as(user)}
        it '投稿の新規作成が成功する' do
          sleep 0.5
          visit new_post_path
          fill_in '飯名', with: 'test_title'
          fill_in 'コメント', with: 'test_content'
          click_button '飯テロする'
          expect(page).to have_content 'test_title'
          expect(page).to have_current_path posts_path
        end
      end

      context '投稿名が未入力' do
        before {login_as(user)}
        it '投稿の新規作成が失敗する' do
          sleep 0.5
          visit new_post_path
          fill_in '投稿名', with: ''
          fill_in 'メモ', with: 'test_content'
          click_button '飯テロする'
          expect(page).to have_content '飯投稿を作成できませんでした'
          expect(page).to have_content "飯名を入力してください"
          expect(page).to have_current_path new_post_path
        end
      end
    end

    describe '投稿の編集、削除' do
      before {login_as(user)}
      context '他人の投稿の場合' do
        it '編集ボタン・削除ボタンが表示されないこと' do
          sleep 0.5
          visit post_path post_by_others
          expect(page).not_to have_selector("#button-edit-#{post_by_others.id}")
          expect(page).not_to have_selector("#button-delete-#{post_by_others.id}")
        end
      end
      context '自分の投稿の場合' do
        it '編集ボタン・削除ボタンが表示されること' do
          sleep 0.5
          visit post_path post
          expect(page).to have_selector("#button-edit-#{post.id}")
          expect(page).to have_selector("#button-delete-#{post.id}")
        end

        it '自分の投稿を編集' do
          sleep 0.5
          visit post_path post
          click_link("button-edit-#{post.id}")
          fill_in '飯名', with: 'edit_title'
          fill_in 'コメント', with: 'edit_content'
          click_button '飯テロする'
          expect(page).to have_content 'edit_title'
          expect(page).to have_content 'edit_content'
          expect(page).to have_current_path post_path post
        end

        it '自分の投稿を削除' do
          sleep 0.5
          visit post_path post
          click_link("button-delete-#{post.id}")
          expect(page.accept_confirm).to eq "削除しますか？"
          expect(page).not_to have_content(post.name)
          expect(page).to have_current_path posts_path
        end
      end
    end
  end
end
