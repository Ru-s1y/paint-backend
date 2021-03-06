Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3000', 'https://imitless-sands-71522.herokuapp.com'
    resource '*',
      headers: :any,
      expose: ['X-Authentication-Token'],
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end