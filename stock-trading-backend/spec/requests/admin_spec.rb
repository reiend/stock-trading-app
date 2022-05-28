# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin', type: :request do
  before(:each) do
    @account_admin = FactoryBot.create :admin
    @account_admin.confirm
    @account_trader = FactoryBot.create :trader
    sign_in @account_admin
  end

  describe 'Get' do
    describe '/admin/traders/pending_appprove' do
      before(:each) do
        get '/admin/traders/pending_appprove'
      end
      it '1, success response' do
        expect(response).to have_http_status(:success)
      end
      it '2, response json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
      it '3, render trader that need admin approval' do
        expect { response.body }.to_not raise_error
      end
    end
  end

  describe 'Post' do
    describe '/admin/trader/create' do
      before(:each) do
        headers = { 'ACCEPT' => 'application/json' }
        post '/admin/trader/create', params: {
          account: {
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: Faker::Internet.safe_email,
            password: Faker::Internet.password
            # role -> trader by default
          }
        }, headers:
      end
      it '1, successfully created a trader' do
        expect(response).to have_http_status(200)
      end
      it '2, response json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'Patch' do
    describe '/admin/trader/:id/approve' do
      before(:each) do
        headers = { 'ACCEPT' => 'application/json' }
        trader_created_id = @account_trader.id
        patch "/admin/trader/#{trader_created_id}/approve", headers:
      end

      it '1, successfully approved a trader' do
        expect(response).to have_http_status(:success)
      end

      it '2, response json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
