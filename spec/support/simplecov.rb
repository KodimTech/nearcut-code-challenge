require 'simplecov'

SimpleCov.start do
  minimum_coverage 75
  add_filter 'app/serializers'
  add_filter 'config/routes'
  add_group 'Models', %w[app/models spec/models]
  add_group 'Controllers', %w[app/controllers spec/controllers]
  add_group 'Helpers', %w[app/helpers spec/helpers]
end
