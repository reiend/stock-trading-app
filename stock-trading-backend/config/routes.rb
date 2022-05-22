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
