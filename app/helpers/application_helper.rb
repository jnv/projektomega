module ApplicationHelper

  def inherited_resources?
    respond_to?(:resource)
  end

  def delete_button(resource)
    button_to "Smazat", resource, method: :delete, confirm: "Opravdu smazat #{resource}?"
  end

  def resource_sym
    resource_class.name.underscore.to_sym
  end
end
