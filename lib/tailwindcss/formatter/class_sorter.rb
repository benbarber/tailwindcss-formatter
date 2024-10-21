# frozen_string_literal: true

require_relative "constants"

module Tailwindcss
  module Formatter
    # The Tailwindcss::Formatter::ClassSorter class is responsible for sorting
    # Tailwind CSS classes in a consistent order according to best practices.
    # This helps ensure that Tailwind CSS classes in HTML or other templates are
    # ordered logically, improving readability and maintainability of the code.
    #
    # The sorting is based on predefined patterns for class categories such as
    # layout, typography, colors, etc.
    class ClassSorter
      def initialize(check_formatted: false, write: false)
        @check_formatted = check_formatted
        @write = write
      end

      def process_file(file)
        original_content = File.read(file)
        formatted_content = format_content(original_content)

        # Check if the file was formatted
        if formatted_content == original_content
          # File was allready formatted correctly
          puts "\e[90m#{file}\e[0m"
        else
          puts file
          fail_format_check if @check_formatted
          File.write(file, formatted_content) if @write
        end
      end

      def sorted_class_string(str)
        class_string = str.dup
        class_list = []
        template_tags = extract_template_tags(class_string)

        # Remove the found template tags from the class_string
        template_tags.each do |tag|
          class_string.gsub!(tag, "")
        end

        # Split the remaing class_string by whitespace
        class_list += class_string.split(/\s+/)

        # Sort the class_list
        sorted_class_list = sort_class_list(class_list)

        # Add the filtered template tags back to the sorted class list
        sorted_class_list += template_tags

        # Join and return the sorted class list as a formatted class_string
        sorted_class_list.join(" ")
      end

      def fail_format_check
        puts "Check format failure - exited with error code 1"
        exit(1)
      end

      private

      def extract_template_tags(class_string)
        template_tags = []

        # Check for ERB template tags
        template_tags += class_string.scan(/<%.*?%>/)

        template_tags
      end

      def sort_class_list(class_list)
        class_list.sort_by do |class_name|
          order_index = CLASS_ORDER.index(class_name)
          order_index.nil? ? [1, class_name] : [0, order_index]
        end
      end

      def format_content(content)
        CLASS_REGEX_PATTERNS.each do |regex|
          content = content.gsub(regex[:pattern]) do |_match|
            "#{regex[:prefix]}\"#{sorted_class_string(Regexp.last_match(1))}\""
          end
        end

        content
      end
    end
  end
end
