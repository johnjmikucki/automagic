require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe DonutsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Donut. As you add validations to Donut, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    #skip("Add a hash of attributes valid for your model")
    {
        name: "plain",
        released:true,
        ad_copy: "The classic.  Put it in your coffee."
    }
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # DonutsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all donuts as @donuts" do
      donut = Donut.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:donuts)).to eq([donut])
    end
  end

  describe "GET show" do
    it "assigns the requested donut as @donut" do
      donut = Donut.create! valid_attributes
      get :show, {:id => donut.to_param}, valid_session
      expect(assigns(:donut)).to eq(donut)
    end
  end

  describe "GET new" do
    it "assigns a new donut as @donut" do
      get :new, {}, valid_session
      expect(assigns(:donut)).to be_a_new(Donut)
    end
  end

  describe "GET edit" do
    it "assigns the requested donut as @donut" do
      donut = Donut.create! valid_attributes
      get :edit, {:id => donut.to_param}, valid_session
      expect(assigns(:donut)).to eq(donut)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Donut" do
        expect {
          post :create, {:donut => valid_attributes}, valid_session
        }.to change(Donut, :count).by(1)
      end

      it "assigns a newly created donut as @donut" do
        post :create, {:donut => valid_attributes}, valid_session
        expect(assigns(:donut)).to be_a(Donut)
        expect(assigns(:donut)).to be_persisted
      end

      it "redirects to the created donut" do
        post :create, {:donut => valid_attributes}, valid_session
        expect(response).to redirect_to(Donut.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved donut as @donut" do
        post :create, {:donut => invalid_attributes}, valid_session
        expect(assigns(:donut)).to be_a_new(Donut)
      end

      it "re-renders the 'new' template" do
        post :create, {:donut => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {
            name: "new_hot_donut",
            released:true,
            ad_copy: "The new hotness.  You want this baby in your coffee."
        }
      }

      it "updates the requested donut" do
        donut = Donut.create! valid_attributes
        put :update, {:id => donut.to_param, :donut => new_attributes}, valid_session
        donut.reload
        expect(donut.name).to eq("new_hot_donut")
        expect(donut.released).to eq(true)
        expect(donut.ad_copy).to match(/The new hotness/)
      end

      it "assigns the requested donut as @donut" do
        donut = Donut.create! valid_attributes
        put :update, {:id => donut.to_param, :donut => valid_attributes}, valid_session
        expect(assigns(:donut)).to eq(donut)
      end

      it "redirects to the donut" do
        donut = Donut.create! valid_attributes
        put :update, {:id => donut.to_param, :donut => valid_attributes}, valid_session
        expect(response).to redirect_to(donut)
      end
    end

    describe "with invalid params" do
      it "assigns the donut as @donut" do
        donut = Donut.create! valid_attributes
        put :update, {:id => donut.to_param, :donut => invalid_attributes}, valid_session
        expect(assigns(:donut)).to eq(donut)
      end

      it "re-renders the 'edit' template" do
        donut = Donut.create! valid_attributes
        put :update, {:id => donut.to_param, :donut => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested donut" do
      donut = Donut.create! valid_attributes
      expect {
        delete :destroy, {:id => donut.to_param}, valid_session
      }.to change(Donut, :count).by(-1)
    end

    it "redirects to the donuts list" do
      donut = Donut.create! valid_attributes
      delete :destroy, {:id => donut.to_param}, valid_session
      expect(response).to redirect_to(donuts_url)
    end
  end

end
