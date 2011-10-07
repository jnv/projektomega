module CodesHelper

  def linked_codes entities, exception = nil
    links = entities.map do |entity|
      unless entity == exception
        link_to(entity.code, entity)
      else
        entity.code
      end
    end

    links.join(', ').html_safe
  end

end
