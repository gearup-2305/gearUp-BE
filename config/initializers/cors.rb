Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://gearup-be-2305-079e2d2dfead.herokuapp.com/' # Replace with your Heroku app's URL
    resource '*', headers: :any, methods: [:post]
  end
end
