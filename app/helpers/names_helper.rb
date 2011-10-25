module NamesHelper
  def linked_name(subject)
    link_to subject.full_name, subject
  end
end
