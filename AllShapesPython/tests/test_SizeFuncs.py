import pytest
from SizeFuncs import *


# (89.4,72.32) - 74 fails
@pytest.mark.parametrize("input_val, expected_output",[(89.5,74.5), (89.4,74.5), (79.25,67),(79.23,67),( 0,100),(10, 82)])
def test_getMaxScaleGivenRotation_positive(input_val,expected_output):
    output = getMaxScaleGivenRotation(input_val, False, 768)
    assert output == expected_output

@pytest.mark.parametrize("input_val, expected_output",[(-89.5,-74.5), (-89.4,-74.5), (-79.25,-67),(-79.23,-67),( 0,-100),(-10, -82)])
def test_getMaxScaleGivenRotation_negative(input_val,expected_output):
    output = getMaxScaleGivenRotation(input_val, True, 768)
    assert output == expected_output

@pytest.mark.parametrize("max_scale",[(74.5), (67), (100)])
def test_getRandomSizeGivenMaxScale_positive(max_scale):
    output = getRandomSizeGivenMaxScale(max_scale, False)
    # Test that output is within valid range
    assert output <= max_scale 
    assert output >= 1
    # Test that output is rounded to nearest 0.5
    assert output % 0.5 == 0

@pytest.mark.parametrize("max_scale",[(-74.5), (-67), (-100)])
def test_getRandomSizeGivenMaxScale_negative(max_scale):
    output = getRandomSizeGivenMaxScale(max_scale, True)
    # Test that output is within valid range
    assert output >= max_scale
    assert output <= -1
    # Test that output is rounded to nearest 0.5
    assert output % 0.5 == 0

