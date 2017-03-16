require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do
  let (:user)           { create(:user) }
  let (:topic)          { create(:topic, user: user) }
  let (:bookmark)       { create(:bookmark, topic: topic) }
  let (:built_bookmark) { build(:bookmark, topic: topic) }

  context "signed-in user" do
    before do
      sign_in(user)
    end

    describe "GET #new" do
      it "returns http success" do
        get :new, params: { topic_id: topic.id }
        expect(response).to have_http_status(:success)
      end

      it "instantiates @bookmark" do
        get :new, params: { topic_id: topic.id }
        expect(assigns(:bookmark)).not_to be_nil
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, params: { topic_id: topic.id, id: bookmark.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params: { topic_id: topic.id, id: bookmark.id }
        expect(response).to render_template :edit
      end

      it "assigns bookmark to be updated to @bookmark" do
        get :edit, params: { topic_id: topic.id, id: bookmark.id }
        bookmark_instance = assigns(:bookmark)
        expect(bookmark_instance.id).to eq(bookmark.id)
        expect(bookmark_instance.url).to eq(bookmark.url)
      end
    end

    describe "PUT #update" do
      it "updates bookmark with expected attributes" do
        new_url = "http://test.test.us"
        put :update, params: { topic_id: topic.id, id: bookmark.id, bookmark: { url: new_url }}
        updated_bookmark = assigns(:bookmark)
        expect(updated_bookmark.id).to eq(bookmark.id)
        expect(updated_bookmark.url).to eq(new_url)
      end

      it "redirects to the topic" do
        new_url = "http://test.test.us"
        put :update, params: { topic_id: topic.id, id: bookmark.id, bookmark: { url: new_url }}
        expect(response).to redirect_to [topic]
      end
    end

    describe "POST #create" do
      it "increases the number of bookmark by 1" do
        expect( -> { post :create, params: { topic_id: topic.id, bookmark: { url: built_bookmark.url }}} ).to change(Bookmark,:count).by(1)
      end

      it "assigns the new bookmark to @bookmark" do
        post :create, params: { topic_id: topic.id, bookmark: { url: built_bookmark.url }}
        expect(assigns(:bookmark)).to eq(Bookmark.last)
      end

      it "redirects to the bookmark" do
        post :create, params: { topic_id: topic.id, bookmark: { url: built_bookmark.url }}
        expect(response).to redirect_to(Topic.last)
      end
    end

    describe "DELETE #destroy" do
      it "deletes the topic" do
        delete :destroy, params: { topic_id: topic.id, id: bookmark.id }
        count = Bookmark.where({topic_id: topic.id, id: bookmark.id}).size
        expect(count).to eq 0
      end
    end

 end
end
