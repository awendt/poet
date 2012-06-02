Feature: Seeing more output when running verbosely
  Scenario: Silent by default
    Given a file named "test" with:
    """
    Host te.st
      User me
    """
    When I run `poet`
    Then the output should not contain "Using test"

  Scenario: User sees which files are included
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
    When I run `poet -v`
    Then the output should contain exactly:
    """
    Using customers/first
    Using customers/second

    """
