module ActionButtonHelper
  def action_button(action = nil)
    return unless inherited_resources?
    action ||= action_name
    if action == 'index' or resource.nil?
      render partial: 'shared/buttons/new'
    elsif action == 'show'
      render partial: 'shared/buttons/edit'
    end

    # if target
    #   render partial: 'shared/action_button', locals: {target_action: target}
    # end
  end

  def action_button_translation_key(target_action)
     :"titles.#{controller_name}.#{target_action}"
  end

  def action_button_translation(target_action)
    t action_button_translation_key(target_action),
      default: :"helpers.submit.#{target_action}"
  end

  def action_resource_path(action)
    send(:"#{action}_resource_path")
  end

end
