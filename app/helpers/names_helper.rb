module NamesHelper
  def linked_name(subject)
    link_to subject.full_name, subject, 'data-number' => subject.number
  end
end
