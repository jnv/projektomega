module ViewMacros
  def stub_ability
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end

  def rendered
    Capybara::Node::Simple.new(@rendered)
  end
end

RSpec.configure do |config|
  config.include(ViewMacros, :type => :view)

end