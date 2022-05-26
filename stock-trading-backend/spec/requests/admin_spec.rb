require 'rails_helper'

RSpec.describe 'Admin', type: :request do
  describe 'Post' do
    before(:each) do
      @account_admin = FactoryBot.create :admin
      @account_admin.confirm
      @account_trader = FactoryBot.create :trader
      sign_in @account_trader
    end

    describe '/admin/trader/' do
      before(:each) do
        headers = { 'ACCEPT' => 'application/json' }
        post '/admin/trader', params: {
          account: {
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: Faker::Internet.safe_email,
            password: Faker::Internet.password
            # role -> trader by default
          }
        }, headers:
      end
      it 'successfully created a trader' do
        expect(response).to have_http_status(200)
      end
      it 'response json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    describe 'Patch' do
      describe '/admin/trader/:id' do
        before(:each) do
          headers = { 'ACCEPT' => 'application/json' }
          trader_created_id = @account_trader.id
          patch "/admin/trader/#{trader_created_id}/edit", params: {
            account: {
              confirmed_at: true
            }
          }, headers:
        end

        it 'successfully approved a trader' do
          expect(response).to have_http_status(:success)
        end

        it 'response json' do
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end
    end
  end
end
