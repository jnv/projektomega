module NamesHelper
  def linked_name(subject)
    return '' if subject.nil?
    link_to subject.full_name, subject, 'data-number' => subject.number
  end
end
