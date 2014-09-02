When 'I hit a pry' do
  require 'pry'; binding.pry
end

When /I wait "(.*?)"$/ do |seconds|
  sleep seconds
end

Given /^there is a message queue$/ do
  source_files = Dir.glob("features/support/messages/*.yml")
  target = File.join(current_dir, "telegram/messages/")
  source_files.each do |file|
    FileUtils.cp(file, target)
  end
end
