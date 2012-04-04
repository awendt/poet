Feature: Exit code
  Scenario: Program runs fine
    Given a file named "test" with:
    """
    Host te.st
      User me
    """
    When I run `poet --dir . -o ssh_config`
    Then the exit status should be 0
