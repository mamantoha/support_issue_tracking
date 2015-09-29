require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do

  let(:valid_attributes) {
   { name: 'Name',
    description: 'Description' }
  }

  let(:invalid_attributes) {
     { name: '' }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    context 'as guest user' do
      it "assigns all departments as @departments" do
        department = Department.create! valid_attributes
        get :index, {}, valid_session
        response.should_not be_success
        response.should redirect_to(new_user_session_path)

        expect(assigns(:departments)).to eq(nil)
      end
    end

    context 'as admin user' do
      login_admin

      it "assigns all departments as @departments" do
        department = Department.create! valid_attributes
        get :index, {}, valid_session
        response.should be_success

        expect(assigns(:departments)).to eq([department])
      end
    end
  end

  describe "GET #show" do

    context 'as guest user' do
      it "assigns the requested department as @department" do
        department = Department.create! valid_attributes
        get :show, {:id => department.to_param}, valid_session
        response.should_not be_success
        response.should redirect_to(new_user_session_path)

        expect(assigns(:department)).to eq(nil)
      end
    end

    context 'as admin user' do
      login_admin

      it "assigns the requested department as @department" do
        department = Department.create! valid_attributes
        get :show, {:id => department.to_param}, valid_session
        expect(assigns(:department)).to eq(department)
      end
    end
  end

  describe "GET #new" do
    context 'as admin user' do
      login_admin

      it "assigns a new department as @department" do
        get :new, {}, valid_session
        response.should be_success

        expect(assigns(:department)).to be_a_new(Department)
      end
    end

    context 'as guest user' do
      it "assigns a new department as @department" do
        get :new, {}, valid_session
        response.should_not be_success
        response.should redirect_to(new_user_session_path)

        expect(assigns(:department)).to_not be_a_new(Department)
      end
    end

  end

  describe "GET #edit" do
    login_admin

    it "assigns the requested department as @department" do
      department = Department.create! valid_attributes
      get :edit, {:id => department.to_param}, valid_session
      expect(assigns(:department)).to eq(department)
    end
  end

  describe "POST #create" do

    context 'as admin user' do
      login_admin

      context "with valid params" do
        it "creates a new Department" do
          expect {
            post :create, {:department => valid_attributes}, valid_session
          }.to change(Department, :count).by(1)
        end

        it "assigns a newly created department as @department" do
          post :create, {:department => valid_attributes}, valid_session
          expect(assigns(:department)).to be_a(Department)
          expect(assigns(:department)).to be_persisted
        end

        it "redirects to the created department" do
          post :create, {:department => valid_attributes}, valid_session
          expect(response).to redirect_to(Department.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved department as @department" do
          post :create, {:department => invalid_attributes}, valid_session
          expect(assigns(:department)).to be_a_new(Department)
        end

        it "re-renders the 'new' template" do
          post :create, {:department => invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    context 'as guest user' do
      it "not creates a new Department" do
        expect {
          post :create, {:department => valid_attributes}, valid_session
        }.to_not change(Department, :count)
      end
    end
  end

  describe "PUT #update" do
    context 'as admin user' do
      login_admin

      context "with valid params" do
        let(:new_attributes) { FactoryGirl.attributes_for(:department, name: 'New Name') }

        it "updates the requested department" do
          department = Department.create! valid_attributes
          put :update, {:id => department.to_param, :department => new_attributes}, valid_session

          department.reload
          expect(assigns(:department).attributes['name']).to eq(new_attributes[:name])
        end

        it "assigns the requested department as @department" do
          department = Department.create! valid_attributes
          put :update, {:id => department.to_param, :department => valid_attributes}, valid_session
          expect(assigns(:department)).to eq(department)
        end

        it "redirects to the department" do
          department = Department.create! valid_attributes
          put :update, {:id => department.to_param, :department => valid_attributes}, valid_session
          expect(response).to redirect_to(department)
        end
      end

      context "with invalid params" do
        it "assigns the department as @department" do
          department = Department.create! valid_attributes
          put :update, {:id => department.to_param, :department => invalid_attributes}, valid_session
          expect(assigns(:department)).to eq(department)
        end

        it "re-renders the 'edit' template" do
          department = Department.create! valid_attributes
          put :update, {:id => department.to_param, :department => invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    context 'as guest user' do
      let(:new_attributes) { FactoryGirl.attributes_for(:department, name: 'New Name') }

      it "not updates the requested department" do
        department = Department.create! valid_attributes
        put :update, {:id => department.to_param, :department => new_attributes}, valid_session
        response.should_not be_success
        response.should redirect_to(new_user_session_path)

        department.reload
        expect(assigns(:department)).to eq(nil)
      end
    end

  end

  describe "DELETE #destroy" do

    context 'as admin user' do
      login_admin

      it "destroys the requested department" do
        department = Department.create! valid_attributes
        expect {
          delete :destroy, {:id => department.to_param}, valid_session
        }.to change(Department, :count).by(-1)
      end

      it "redirects to the departments list" do
        department = Department.create! valid_attributes
        delete :destroy, {:id => department.to_param}, valid_session
        expect(response).to redirect_to(departments_url)
      end
    end

    context 'as guest user' do
      it "not destroys the requested department" do
        department = Department.create! valid_attributes
        expect {
          delete :destroy, {:id => department.to_param}, valid_session
        }.to_not change(Department, :count)
      end
    end
  end

end
