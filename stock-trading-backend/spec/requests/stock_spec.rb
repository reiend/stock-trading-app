require 'rails_helper'

RSpec.describe "Stock's Request", type: :request do
  describe 'Get' do
    describe '/stock_list' do
      before(:each) do
        get '/stock_list'
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
end
