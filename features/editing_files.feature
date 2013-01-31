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
