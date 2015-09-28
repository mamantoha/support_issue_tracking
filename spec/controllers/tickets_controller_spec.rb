require 'rails_helper'

describe TicketsController do

  describe 'POST /tickets' do
    describe 'as guest user' do
      it 'should allow me to create a ticket' do
        post :create, ticket: { name: 'Name', subject: 'Ticket', body: 'Body', email: 'user@example.com' }

        expect(response).to redirect_to(assigns(:ticket))
      end
    end

  end

  describe 'GET /tickets' do
    describe 'as admin user' do
      login_admin

      it 'returns tickets' do
        get :index

        response.should be_success
      end
    end

    describe 'as guest user' do
      it 'should not returns tickets' do
        get :index

        response.should redirect_to(new_user_session_path)
        response.should_not be_success
      end
    end

  end

end
