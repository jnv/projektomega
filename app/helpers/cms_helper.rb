module CmsHelper
  def cms_root
    if @cms_site
      @cms_site.pages.root
    else
      Cms::Page.root
    end
  end
end
