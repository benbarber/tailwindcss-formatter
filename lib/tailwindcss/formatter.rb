# frozen_string_literal: true

require "optparse"

require_relative "formatter/version"
require_relative "formatter/class_sorter"

module Tailwindcss
  module Formatter
    # This class handles the command-line interface (CLI) for the TailwindCSS formatter.
    # It processes command-line arguments and passes them to the ClassSorter
    class CLI
      def self.start(argv)
        options = parse_options(argv)
        files = find_files(options[:glob])
        process_files(files, options)
      end

      def self.parse_options(argv)
        options = { glob: "app/**/*.html.erb", check_formatted: false, write: false }

        # Check if the first argument is a glob pattern (positional argument)
        options[:glob] = argv.shift if argv.any? && !argv.first.start_with?("-")

        option_parser(options).parse!(argv)
        options
      end

      def self.option_parser(options)
        OptionParser.new do |opts|
          opts.banner = "Usage: tailwindcss-formatter [options]\n
          Example: tailwindcss-formatter \"app/**/*.html.erb\""

          add_glob_option(opts, options)
          add_write_option(opts, options)
          add_check_formatted_option(opts, options)
        end
      end

      def self.add_glob_option(opts, options)
        opts.on("-g", "--glob GLOB", "Glob path to match files (default: \"app/**/*.html.erb\")") do |glob|
          options[:glob] = glob
        end
      end

      def self.add_write_option(opts, options)
        opts.on("-w", "--write [FLAG]", TrueClass, "Write any formatting back to the files (default: false)") do
          options[:write] = true
        end
      end

      def self.add_check_formatted_option(opts, options)
        opts.on("-c", "--check-formatted [FLAG]", TrueClass,
                "Raises exit 1 if unformatted class strings are detected (default: false)") do
          options[:check_formatted] = true
        end
      end

      def self.find_files(glob)
        files = Dir.glob(glob)

        if files.empty?
          puts "No files matched the glob pattern: #{glob}"
          exit 1
        end

        files
      end

      def self.process_files(files, options)
        class_sorter = ClassSorter.new(check_formatted: options[:check_formatted], write: options[:write])

        files.each do |file|
          class_sorter.process_file(file)
        end
      end
    end
  end
end
