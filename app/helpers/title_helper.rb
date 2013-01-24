module TitleHelper
  def page_title
    if @cms_page
      return @cms_page.label
    else
      t page_title_translation_key,
        page_title_context.merge(:default => :"title.default")
    end
  end

  def page_title_translation_key
    :"titles.#{controller_name}.#{action_name}"
  end

  def page_title_context
    controller.view_assigns.symbolize_keys
  end
end
