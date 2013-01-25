Capybara.add_selector(:link) do
  xpath {|rel| ".//a[@rel='#{rel}']"}
end
