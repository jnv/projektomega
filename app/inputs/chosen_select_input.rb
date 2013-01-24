class ChosenSelectInput < SimpleForm::Inputs::CollectionSelectInput
  enable :placeholder

  def input_html_classes
    super.push('chzn-select')
  end

  def placeholder
    input_html_options[:'data-placeholder'] ||= placeholder_text
    nil
  end

  def placeholder_text
    placeholder = options[:placeholder]
    placeholder.is_a?(String) ? placeholder : translate(:placeholders)
  end
end
