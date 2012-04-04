Feature: Correct permissions
  Scenario: User wants the generated file to work with SSH out-of-the-box.
    Given a file named "permissions" with:
    """
    Host permissio.ns
      User whatever
    """
    When I run `poet --dir . -o ssh_config`
    And I run `ls -la ssh_config`
    Then the file "ssh_config" should not be world-accessible