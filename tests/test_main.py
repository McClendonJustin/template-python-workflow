# ==========================================
# TEST SUITE: Main Application Tests
# ==========================================
# Description: Unit tests for verifying src/main.py logic using Pytest.

# Import pytest framework for assertions and fixtures
import pytest

# Import the specific function(s) we want to test from our src folder structure
from src.main import add_numbers

def test_add_numbers_success():
    """
    Test Case: Verify standard addition works as expected.
    This establishes our baseline 'Green' state.
    """
    result = add_numbers(2, 3)
    assert result == 5

def test_add_numbers_with_negatives():
    """
    Test Case: Verify function handles negative numbers correctly.
    Demonstrates adding edge cases to your test suite.
    """
    result = add_numbers(-1, 1)
    assert result == 0