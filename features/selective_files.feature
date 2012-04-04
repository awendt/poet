Feature: Selectively whitelist files
  Scenario: Does not include disabled files by default
    Given a file named "sometimes.disabled" with:
    """
    Host sometimes
      User me
    """
    And a file named "always" with:
    """
    Host always
      User me
    """
    When I run `poet --dir . -o ssh_config`
    Then the file "ssh_config" should contain "Host always"
    But the file "ssh_config" should not contain "Host sometimes"

  Scenario: Does include disabled files when asked
    Given a file named "sometimes.disabled" with:
    """
    Host sometimes
      User me
    """
    And a file named "always" with:
    """
    Host always
      User me
    """
    When I run `poet --dir . -o ssh_config -w sometimes`
    Then the file "ssh_config" should contain "Host always"
    And the file "ssh_config" should contain "Host sometimes"

  Scenario: Allows to include several disabled files
    Given a file named "sometimes.disabled" with:
    """
    Host sometimes
      User me
    """
    Given a file named "almost_never.disabled" with:
    """
    Host almost_never
      User me
    """
    When I run `poet --dir . -o ssh_config -w sometimes,almost_never`
    Then the file "ssh_config" should contain "Host almost_never"
    And the file "ssh_config" should contain "Host sometimes"
