require 'spec_helper'

describe MarkdownHelper do
  describe "markdown" do
    it "converts markdown text to HTML" do
      helper.markdown("# Hello world").gsub(/\n+/, '').should ==
          "<h1>Hello world</h1>"
    end

  end
end
