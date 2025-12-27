# coding: utf-8
require "./lib/pagseguro/version"

Gem::Specification.new do |spec|
  spec.name                  = "pagseguro-oficial"
  spec.version               = PagSeguro::VERSION
  spec.authors               = ["Nando Vieira"]
  spec.email                 = ["fnando.vieira@gmail.com"]
  spec.summary               = "Biblioteca de integração com o PagSeguro"
  spec.description           = "Biblioteca oficial de integração via API com o PagSeguro"
  spec.homepage              = "http://www.pagseguro.com.br"
  spec.license               = "ASL"

  spec.files                 = `git ls-files`.split($/)
  spec.executables           = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files            = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths         = ["lib"]

  spec.required_ruby_version = ">= 2.7.0"

  spec.add_runtime_dependency "aitch", "~> 0.2"
  spec.add_runtime_dependency "nokogiri", "~> 1.13"
  spec.add_runtime_dependency "i18n", "~> 1.8"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.10"
  spec.add_development_dependency "webmock", "~> 3.14"
  spec.add_development_dependency "activesupport", "~> 6.0"
end
