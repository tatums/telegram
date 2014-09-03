Then /^I should see "(.*?)" in the message list$/ do |body|
  expect(all_output).to match body
end

Then /^I should have "(.*?)" pending message$/ do |msg_count|
  expect(all_output).to match "#{msg_count} pending messages"
end

Then /^I should have "(.*?)" messages$/ do |msg_count|
  expect(all_output).to match "#{msg_count} messages"
end

Then /^I see "(.*?)" is not in the message list$/ do |body|
  expect(all_output).not_to match body
end
