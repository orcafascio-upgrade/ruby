require "bundler/setup"
Bundler.require(:default, :development)

I18n.enforce_available_locales = false
require "webmock/rspec"
require "pagseguro"

WebMock.disable_net_connect!(allow_localhost: true)

# Load support files in order - fakeweb_compat must be loaded first
require "./spec/support/fakeweb_compat"
Dir["./spec/support/**/*.rb"].each do |file|
  require file unless file.include?("fakeweb_compat")
end

I18n.exception_handler = proc do |scope, *args|
  message = scope.to_s
  raise message unless message.include?(".i18n.plural.rule")
end

I18n.default_locale = "pt-BR"
I18n.locale = ENV.fetch("LOCALE", I18n.default_locale)

RSpec.configure do |config|
  config.before(:each) do
    load "./lib/pagseguro.rb"
    WebMock.reset!
  end

  config.after do
    PagSeguro.configure do |config|
      config.app_id = nil
      config.environment = :production
      config.app_key = nil
      config.email = nil
      config.token = nil
    end
  end
end
