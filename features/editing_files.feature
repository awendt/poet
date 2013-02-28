Feature: Editing files
  Scenario: User wants to edit files quickly
    Given a file named "favorite_editor" with:
    """
    Host vim
      User me
    """
    When I set env variable "EDITOR" to "/bin/cat"
    And I run `poet edit favorite_editor`
    Then the output from "poet edit favorite_editor" should contain "Host vim"
    And the file "ssh_config" should contain "Host vim"

  Scenario: Show warning when user does not have EDITOR set
    Given a file named "no_editor" with:
    """
    Host none
      User me
    """
    When I set env variable "EDITOR" to ""
    And I run `poet edit no_editor`
    Then the output from "poet edit no_editor" should contain "$EDITOR is empty. Could not determine your favorite editor."
    And the exit status should not be 0

  Scenario: Do not re-create ssh_config when no file was created
    Given a file named "important" with:
    """
    This is absolutely vital information
    """
    When I set env variable "EDITOR" to "/bin/cat"
    And I run `poet edit missing -o important`
    Then the output from "poet edit missing -o important" should not contain "Found hand-crafted ssh_config"
    And the exit status should be 0

  Scenario: ssh_config is re-generated after changing files
    Given a file named "file1" with:
    """
    Host one
      User me
    """
    And a file named "file2" with:
    """
    Host two
      User me
    """
    And a file named "important" with:
    """
    This is absolutely vital information
    """
    When I set env variable "EDITOR" to "mv file2"
    And I run `poet edit file1 -o important`
    Then the output from "poet edit file1 -o important" should contain "Found hand-crafted ssh_config"
    And the exit status should not be 0

  Scenario: ssh_config is not re-generated after not changing files
    Given a file named "file1" with:
    """
    Host one
      User me
    """
    And a file named "file2" with:
    """
    Host two
      User me
    """
    And a file named "important" with:
    """
    This is absolutely vital information
    """
    When I set env variable "EDITOR" to "/bin/cat"
    And I run `poet edit file1 -o important`
    Then the output from "poet edit file1 -o important" should not contain "Found hand-crafted ssh_config"
    And the exit status should be 0

  Scenario: ssh_config includes disabled file after editing it
    Given a file named "homeoffice.disabled" with:
    """
    Host normally_disabled
      User me
    """
    When I poet-edit file "homeoffice.disabled" and change something
    Then the exit status should be 0
    And the file "ssh_config" should contain "Host normally_disabled"