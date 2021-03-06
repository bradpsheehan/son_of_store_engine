require 'spec_helper'

describe OrdersController do
  describe 'index' do
    context 'when the user is logged in' do

      context 'when the user has orders in their history' do
        it 'renders the index view' do
          user = FactoryGirl.create(:user)
          login_user user
          expect(response).to be_success
        end

        it 'assigns the user variable' do
          user = FactoryGirl.create(:user)
          login_user user
          get :index
          assigns(user).should eq @user
        end

        it 'assigns order variables' do
          user = FactoryGirl.create(:user)
          login_user user
          orders = Order.create(user_id: user.id, status:"pending")
          get :index
          assigns(orders).should eq @orders
        end
      end
    end

    context 'when the user is NOT logged in' do
      it 'redirects them to the log in page' do
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'show' do
    context 'when the user is logged in' do

      context 'when the order belongs to the user' do
        it 'assigns the order variable' do
          user = FactoryGirl.create(:user)
          order = FactoryGirl.create(:order, user: user)
          login_user user
          get :show, params = {id: order.id}
          assigns(order).should eq @order
        end
      end

      context 'when the order does NOT belong to the user' do
        it 'redirects to the order history' do
          user = FactoryGirl.create(:user)
          user2 = FactoryGirl.create(:user, email: 'sneaky@laura.com')
          order = FactoryGirl.create(:order, user: user)
          login_user user2
          get :show, params = {id: order.id}
          expect(response).to redirect_to account_orders_path
        end
      end
    end

    context 'when the user is not logged in' do
      it 'redirects the user to the login page' do
        get :show
        expect(response).to redirect_to login_path
      end
    end
  end
end
