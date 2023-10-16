Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://gearup-be-2305-079e2d2dfead.herokuapp.com/' 
    resource '/graphql', headers: :any, methods: [:post, :options]
  end
end
