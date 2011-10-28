module MarkdownHelper
  def markdown(text)
    options = [:filter_html, :filter_styles, :autolink]
    Redcarpet.new(text, *options).to_html.html_safe
  end
end
