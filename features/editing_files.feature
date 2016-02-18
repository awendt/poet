Feature: Editing files
  Scenario: Show warning when user does not have EDITOR set
    Given a file named "no_editor" with:
    """
    Host none
      User me
    """
    When I set the environment variable "EDITOR" to ""
    And I run `poet edit no_editor`
    Then the output from "poet edit no_editor" should contain "$EDITOR is empty. Could not determine your favorite editor."
    And the exit status should not be 0

  Scenario: Do not re-create ssh_config when no file was created
    Given a file named "important" with:
    """
    This is absolutely vital information
    """
    When I set the environment variable "EDITOR" to "/bin/cat"
    And I run `poet edit missing -o important`
    Then the output from "poet edit missing -o important" should not contain "Found hand-crafted ssh_config"
    And the file "important" should contain "This is absolutely vital information"
    And the exit status should be 0

  Scenario: ssh_config is re-generated after changing files
    Given a file named "file1" with:
    """
    Host one
      User me
    """
    And the file "ssh_config" should not exist

    When I poet-edit file "file1" and change something
    Then the exit status should be 0
    And the file "ssh_config" should contain "Host one"

  Scenario: ssh_config is not re-generated after not changing files
    Given a file named "file1" with:
    """
    Host one
      User me
    """
    And the file "ssh_config" should not exist

    When I poet-edit file "file1" without changing something
    Then the exit status should be 0
    And the file "ssh_config" should not exist

  Scenario: ssh_config includes disabled file after editing it
    Given a file named "homeoffice.disabled" with:
    """
    Host normally_disabled
      User me
    """
    When I run `poet`
    Then the exit status should be 0
    And the file "ssh_config" should not contain "Host normally_disabled"

    When I poet-edit file "homeoffice.disabled" and change something
    Then the exit status should be 0
    And the file "ssh_config" should contain "Host normally_disabled"