# Rounds the floating number either to a whole number or 0.5
def  roundToHalf(value: float, negativeRotation: bool) -> float:

    decimalNums = abs(int((value % 1)*100))
        
    
    if decimalNums < 75 and decimalNums > 25:
        if negativeRotation:
            value = int(value) - 0.5
        else:
            value = int(value) + 0.5;
            
    else:
        value = round(value)
    


    return value;
