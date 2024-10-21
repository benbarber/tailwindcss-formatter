# frozen_string_literal: true

RSpec.describe Tailwindcss::Formatter do
  it "has a version number" do
    expect(Tailwindcss::Formatter::VERSION).not_to be nil
  end

  it "formats a string with ERB template tags" do
    sorter = Tailwindcss::Formatter::ClassSorter.new

    src = "rounded-lg py-2  mb-2 shadow-lg  px-6 <%= raised ? 'shadow-xl' : 'shadow' %> <% another %>"
    formatted_src = "py-2 px-6 mb-2 rounded-lg shadow-lg <%= raised ? 'shadow-xl' : 'shadow' %> <% another %>"

    result = sorter.sorted_class_string(src)

    expect(result).to eq(formatted_src)
  end

  it "matches correctly on html" do
    html = <<-HTML
    <div
        class="py-2 px-6 text-white rounded-lg <%= raised ? 'shadow-xl' : 'shadow' %>"
        data-controller="messages"
    >
      <%= message %>
    </div>
    HTML

    expected_match = "py-2 px-6 text-white rounded-lg <%= raised ? 'shadow-xl' : 'shadow' %>"

    match = html.match(/\s*["']([^"]*)["']/)
    expect(match[1]).to eq(expected_match)
  end
end
