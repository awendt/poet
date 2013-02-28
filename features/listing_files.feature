Feature: Listing files

  Scenario: Listing files without tree
    Given a directory named "foo/bar"
    And a file named "foo/bar/conf1" with:
    """
    Host one
    """
    And a file named "foo/conf2.disabled" with:
    """
    Host two
    """
    When I run `poet ls`
    Then the output should contain exactly:
    """
    foo/bar/conf1
    foo/conf2.disabled

    """

  Scenario: Listing files with tree
    Given a directory named "foo/bar"
    And a file named "foo/bar/conf1" with:
    """
    Host one
    """
    And a file named "foo/conf2.disabled" with:
    """
    Host two
    """
    When I run `poet ls -t`
    Then the output should contain exactly:
    """
    |-- foo
    |   |-- bar
    |   |   |-- conf1
    |   |-- conf2.disabled

    """
