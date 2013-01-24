module ApplicationHelper

  def inherited_resources?
    respond_to?(:resource)
  end

end
