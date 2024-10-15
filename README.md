# Tailwindcss::Formatter

This Ruby Gem provides a CLI interface for formatting and sorting your Tailwind CSS
class declarations that are defined in your HTML and ERB templates.

## Installation

Install the gem and add it to the application's Gemfile by executing:

```bash
bundle add tailwindcss-formatter
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install tailwindcss-formatter
```

## Usage

Once installed, you can run the formatter from the CLI to format your files. It runs
in dry mode by default, so you will need to specify the `-w | --write` flag to have the
modifications written back to the files in place.

It takes a glob or file path as the first argument. If you leave this empty, it will
use the default, which is set up for a typical Rails project: `"app/**/*.html.erb"`.

Example with glob pattern to match files:

```bash
tailwindcss-format "app/**/*.html.erb"
```

Example passing the `--write` flag so the formatting is written to the files in place:

```bash
tailwindcss-format "app/**/*.html.erb" -w
```

### Flags

`-w | --write`             Writes the formatted class strings back to the file in place.

`-c | --check-formatted`   Raises exit code 1 if unformatted class declarations are detected.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec`
to run the tests. You can also run `bin/console` for an interactive prompt that will allow
you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a
new version, update the version number in `version.rb`, and then run `bundle exec rake release`,
which will create a git tag for the version, push git commits and the created tag, and push
the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/benbarber/tailwindcss-formatter.
