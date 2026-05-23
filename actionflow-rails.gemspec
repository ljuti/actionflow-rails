# frozen_string_literal: true

require_relative "lib/actionflow/rails/version"

Gem::Specification.new do |spec|
  spec.name = "actionflow-rails"
  spec.version = Actionflow::Rails::VERSION::STRING
  spec.authors = ["Lauri Jutila"]
  spec.email = ["ljuti@nmux.dev"]

  spec.summary = "Rails integration for the Actionflow workflow gem"
  spec.description = "Provides Rails generators, automatic logger configuration, " \
    "and Railtie integration for Actionflow workflows."
  spec.homepage = "https://github.com/ljuti/actionflow-rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ljuti/actionflow-rails"
  spec.metadata["changelog_uri"] = "https://github.com/ljuti/actionflow-rails/blob/main/CHANGELOG.md"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .standard.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "actionflow", "~> 0.1.0"
  spec.add_dependency "railties", ">= 6.0"

  spec.add_development_dependency "mutant-rspec", "~> 0.16.0"
  spec.add_development_dependency "rspec-rails", "~> 6.0"
end
