import pytest
from UtilFuncs import *

@pytest.mark.parametrize("input_val, expected_output",[(89.5,89.5), (89.4,89.5), (79.25,79),(79.23,79),( 0,0),(10, 10)])
def test_roundToHalf_positive(input_val,expected_output):
    output = roundToHalf(input_val, False)
    assert output == expected_output


@pytest.mark.parametrize("input_val, expected_output",[(-89.5,-89.5), (-89.4,-89.5), (-79.25,-79),(-79.23,-79),( 0,0),(-10,-10)])
def test_roundToHalf_negative(input_val,expected_output):
    output = roundToHalf(input_val, True)
    assert output == expected_output