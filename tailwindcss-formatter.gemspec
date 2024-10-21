# frozen_string_literal: true

require_relative "lib/tailwindcss/formatter/version"

Gem::Specification.new do |spec|
  spec.name = "tailwindcss-formatter"
  spec.version = Tailwindcss::Formatter::VERSION
  spec.required_ruby_version = ">= 3.0.0"
  spec.licenses = %w[MIT]

  spec.authors = ["Ben Barber"]
  spec.email = ["contact@benbarber.co.uk"]
  spec.homepage = "https://github.com/benbarber/tailwindcss-formatter#readme"

  spec.summary = "Effortlessly organize and format Tailwind CSS class declarations in your HTML and ERB
  templates, following the recommended class order for cleaner and more maintainable code."

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/benbarber/tailwindcss-formatter"
  spec.metadata["changelog_uri"] = "https://github.com/benbarber/tailwindcss-formatter/#changelog"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  File.basename(__FILE__)
  spec.files = Dir["lib/**/*", "exe/**/*", "*.gemspec", "README.md", "LICENSE"]

  # Specify the path for the executable
  spec.bindir = "exe"
  spec.executables = ["tailwindcss-format"]

  # Add the lib directory to the load path
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
