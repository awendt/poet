Feature: Running the program
  Scenario: Program runs fine
    Given a file named "test" with:
    """
    Host te.st
      User me
    """
    When I run `poet --dir . -o ssh_config`
    Then the exit status should be 0
    And the file "ssh_config" should contain "Host te.st"

  Scenario: Does not overwrite existing files
    Given a file named "important" with:
    """
    This is absolutely vital information
    """
    When I run `poet --dir . -o important`
    Then the output from "poet --dir . -o important" should contain "Found hand-crafted ssh_config"
    And the exit status should not be 0
    And the file "important" should contain "This is absolutely vital information"
