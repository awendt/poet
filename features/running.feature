Feature: Running the program
  Scenario: User runs the program
    Given a file named "test" with:
    """
    Host te.st
      User me
    """
    When I run `poet`
    Then the exit status should be 0
    And the file "ssh_config" should contain "Host te.st"

  Scenario: User wants her own files not to be overwritten
    Given a file named "important" with:
    """
    This is absolutely vital information
    """
    When I run `poet -o important`
    Then the output from "poet -o important" should contain "Found hand-crafted ssh_config"
    And the exit status should not be 0
    And the file "important" should contain "This is absolutely vital information"

  Scenario: User wants sensible warnings
    Given a file named "test" with:
    """
    Host te.st
      User me
    """
    When I run `poet --dir missing`
    Then the output from "poet --dir missing" should contain "missing does not exist"
    And the exit status should not be 0

  Scenario: User wants to organize his config files in folders
    Given a directory named "customers"
    And a file named "customers/first" with:
    """
    Host customer1
      User me
    """
    And a file named "customers/second" with:
    """
    Host customer2
      User me
    """
    When I run `poet`
    Then the exit status should be 0
    And the file "ssh_config" should contain "Host customer1"
    And the file "ssh_config" should contain "Host customer2"