Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ['http://localhost:3000', 'https://gear-up-ui-ux.vercel.app']

    resource "/graphql",
             headers: :any,
             methods: %i[get post put patch delete options head]
  end
end