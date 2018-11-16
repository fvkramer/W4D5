require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:each) { User.create(username: "tiger", password: "password") }
  describe "GET #index" do
    it "renders the index page" do
      get :index

      expect(response).to render_template("index")
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #new" do
    it "renders the new page" do
      get :new

      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    it "renders the show page" do

      get :show, params: {id: User.last.id}

      expect(response).to render_template("show")
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #edit" do
    it "renders the edit page" do
      get :edit, params: {id: User.last.id }

      expect(response).to render_template("edit")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "redirects to the User show page" do
        post :create, params: { user: { username: "interpretive_dance", password: "bourgeoisie" } }

        expect(response).to redirect_to(user_url(User.last))
        expect(User.find_by(username: "interpretive_dance")).not_to be_nil
      end
    end

    context "with invalid params" do
      it "validates presence of username and password" do
        post :create, params: { user: { username: "", password: "" } }

        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "redirects to the User show page" do
        patch :update, params: { id: User.last.id, user: { username: "interpretive_dance", password: "bourgeoisie" } }

        expect(response).to redirect_to(user_url(User.last))
        expect(User.find_by(username: "interpretive_dance")).not_to be_nil
      end
    end

    context "with invalid params" do
      it "validates presence of username and password" do
        patch :update, params: { id: User.last.id, user: { username: "", password: "" } }

        expect(response).to render_template('edit')
        expect(flash[:errors]).to be_present
      end
    end
  end



  describe "DELETE #destroy" do
    it "redirects to #index" do
      delete :destroy, params: { id: User.last.id }

      expect(response).to redirect_to(users_url)
    end

    it "promptly removes the user from the database" do
      user = User.last
      delete :destroy, params: { id: User.last.id }

      expect(User.find_by(username: user.username)).to be_nil
    end
  end
end
