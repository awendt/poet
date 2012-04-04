Then /^the file "([^"]*)" should not be world-accessible$/ do |filename|
  step %Q(the output from "ls -la #{filename}" should contain "-rw-------")
end