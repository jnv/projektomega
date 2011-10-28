module MarkdownHelper
  def markdown(text)
    #options = [:filter_html, :filter_styles, :autolink]
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, lax_html_blocks: true)
    @markdown.render(text).html_safe
  end
end
