Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

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
  end
end
