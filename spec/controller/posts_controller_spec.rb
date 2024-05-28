require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "assigns the requested post to @post" do
      post = create(:post)
      get :show, params: { id: post.id }
      expect(assigns(:post)).to eq(post)
    end
    
    it "renders the show template" do
      post = create(:post)
      get :show, params: { id: post.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "assigns a new post to @post" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
    
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) { { post: attributes_for(:post) } }

      it "creates a new post" do
        expect {
          post :create, params: valid_params
        }.to change(Post, :count).by(1)
      end

      it "redirects to posts path" do
        post :create, params: valid_params
        expect(response).to redirect_to(posts_path)
      end

      it "sets a success notice" do
        post :create, params: valid_params
        expect(flash[:notice]).to eq('Post was successfully created.')
      end
      context "with invalid params" do
        let(:invalid_params) { { post: { title: "", body: "" } } }
  
        it "does not create a new post" do
          expect {
            post :create, params: invalid_params
          }.not_to change(Post, :count)
        end
  
        it "renders the new template on failed create" do
          post :create, params: invalid_params
          expect(response).to render_template(:new)
        end
      end
    end

  describe "DELETE #destroy" do
    it "destroys the post" do
      post_to_destroy = create(:post, user: user)
      expect {
        delete :destroy, params: { id: post_to_destroy.id }
      }.to change(Post, :count).by(-1)
    end
  end

  describe "PATCH #update" do
    let(:post) { create(:post, user: user) }
    let(:new_attributes) { { title: "Updated Title", body: "Updated Body" } }

    context "with valid params" do
      it "updates the post" do
        patch :update, params: { id: post.id, post: new_attributes }
        post.reload
        expect(post.title).to eq("Updated Title")
        expect(post.body).to eq("Updated Body")
      end

      it "redirects to posts path with success notice on successful update" do
        patch :update, params: { id: post.id, post: new_attributes }
        expect(response).to redirect_to(posts_path)
        expect(flash[:notice]).to eq('Post was successfully updated.')
      end
      context "with invalid params" do
        it "does not update the post" do
          patch :update, params: { id: post.id, post: { title: "", body: "" } }
          post.reload
          expect(post.title).not_to eq("")
          expect(post.body).not_to eq("")
        end
  
        it "renders the edit template on failed update" do
          patch :update, params: { id: post.id, post: { title: "", body: "" } }
          expect(response).to render_template(:edit)
        end
      end
    end
  end

  end

end
