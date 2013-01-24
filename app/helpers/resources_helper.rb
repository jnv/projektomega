module ResourcesHelper
  def resource_name(resource = nil)
    resource ||= resource_class
    resource.model_name.human
  end

  def resource_i18n_key(klass = nil)
    klass ||= resource_class
    klass.model_name.i18n_key
  end

  def collection_sym(klass = nil)
    klass ||= resource_class
    klass.model_name.plural.to_sym
  end
end
