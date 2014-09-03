Then /^I should see a message has been created$/ do
  expect(all_output).to match "Message created!"
end
