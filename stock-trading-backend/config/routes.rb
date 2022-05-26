Rails.application.routes.draw do
  devise_for :accounts, path: '', path_names: {
    sign_in: 'signin',
    sign_out: 'signout',
    registration: 'signup'
  },
                        controllers: {
                          sessions: 'accounts/sessions',
                          registrations: 'accounts/registrations'
                        }

  get '/current_account', to: 'current_account#index'
  get '/current_account/stocks_bought', to: 'current_account#stocks_bought'
  get '/current_account/stocks_sold', to: 'current_account#stocks_bought'
  get '/current_account/transactions', to: 'current_account#transactions'

  get '/current_account/trader_list', to: 'current_account#trader_list'

  post '/admin/trader/create', to: 'admin#create'
end
