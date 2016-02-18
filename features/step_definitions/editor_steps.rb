When /^I poet\-edit file "([^"]*)" and change something$/ do |filename|
  step %Q(I set the environment variable "EDITOR" to "#{File.expand_path('../../../editors/double_space.rb', __FILE__)}")
  step "I run `poet edit #{filename}`"
end

When /^I poet\-edit file "([^"]*)" without changing something$/ do |filename|
  step 'I set the environment variable "EDITOR" to "/bin/cat"'
  step "I run `poet edit #{filename}`"
end
