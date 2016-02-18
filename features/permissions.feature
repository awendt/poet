Feature: Correct permissions
  Scenario: User wants the generated file to work with SSH out-of-the-box.
    Given a file named "permissions" with:
    """
    Host permissio.ns
      User whatever
    """
    When I run `poet`
    Then the file "ssh_config" should have permissions "0600"
