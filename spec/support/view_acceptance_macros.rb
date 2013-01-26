module ViewAcceptanceMacros
  include ActionController::RecordIdentifier

  def css_dom_id(record)
    "##{dom_id(record)}"
  end
end

RSpec.configure do |config|
  config.include ViewAcceptanceMacros, :type => :view
  config.include ViewAcceptanceMacros, :type => :feature
end
