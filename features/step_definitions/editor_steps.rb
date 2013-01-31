When /^I set env variable "(\w+)" to "([^"]*)"$/ do |var, value|
  ENV[var] = value
end
