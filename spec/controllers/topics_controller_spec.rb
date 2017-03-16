require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  let (:user)        { create(:user) }
  let (:topic)       { create(:topic, user: user) }
  let (:built_topic) { build(:topic, user: user) }

  context "signed-in user" do
    before do
      sign_in(user)
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, params: { id: topic.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: topic.id }
        expect(assigns(:topic)).to eq(topic)
      end

      it "assigns topic to @topic" do
        get :show, params: { id: topic.id }
        expect(assigns(:topic)).to eq(topic)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the new view" do
        get :new
        expect(response).to render_template :new
      end

      it "instantiates @topic" do
        get :new
        expect(assigns(:topic)).not_to be_nil
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, params: { id: topic.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params: { id: topic.id }
        expect(response).to render_template :edit
      end

      it "assigns topic to be updated to @topic" do
        get :edit, params: { id: topic.id }
        topic_instance = assigns(:topic)
        expect(topic_instance.id).to eq(topic.id)
        expect(topic_instance.title).to eq(topic.title)
      end
    end

    describe "PUT update" do
      it "updates topic with expected attributes" do
        new_title = "This is a new title"
        put :update, params: { id: topic.id, topic: { title: new_title }}
        updated_topic = assigns(:topic)
        expect(updated_topic.id).to eq(topic.id)
        expect(updated_topic.title).to eq(new_title)
      end

      it "redirects to the updated topic" do
        new_title = "This is a new title"
        put :update, params: { id: topic.id, topic: { title: new_title }}
        expect(response).to redirect_to [topic]
      end
    end

    describe "POST create" do
      it "increases the number of topic by 1" do
        expect( -> { post :create, params: { topic: { title: built_topic.title }}} ).to change(Topic,:count).by(1)
      end

      it "assigns the new topic to @topic" do
        post :create, params: { topic: { title: built_topic.title }}
        expect(assigns(:topic)).to eq(Topic.last)
      end

      it "redirects to the new topic" do
        post :create, params: { topic: { title: built_topic.title }}
        expect(response).to redirect_to(Topic.last)
      end
    end

    describe "DELETE destroy" do
      it "deletes the topic" do
        delete :destroy, params: { id: topic.id }
        count = Topic.where({id: topic.id}).size
        expect(count).to eq 0
      end
    end

  end
end
