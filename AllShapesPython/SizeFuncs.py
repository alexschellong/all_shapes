from math import sin,radians, sqrt
import random
from UtilFuncs import *

def getMaxScaleGivenRotation(rotation: float, negativeRotationBool: bool, height: int) -> float:
  
    halfHeight = height/2.0;
    cornerDistanceToEdge = None
    ratioDiagonalRotation = 216.87;

    if (negativeRotationBool):
        # negative tive rotation - rect touching the lower left corner 

        shapeDiagonalRotation =  ratioDiagonalRotation - rotation;
        #print("shapeDiagonalRotation:"+shapeDiagonalRotation)

        if (shapeDiagonalRotation >= ratioDiagonalRotation):  
        # rect touching top left corner

            cornerDistanceToEdge = (halfHeight/sin(radians(shapeDiagonalRotation)));

        else:
            print("error top --> side");

    else:
        # positive rotation - rect touching the  lower right  corner 
        shapeDiagonalRotation =  ratioDiagonalRotation + rotation;

        #print("shapeDiagonalRotation:"+shapeDiagonalRotation);
        if (shapeDiagonalRotation >= ratioDiagonalRotation):
        # rect touching the top 

            cornerDistanceToEdge = -(halfHeight/sin(radians(shapeDiagonalRotation)));

        else:
            print("error bottom --> side");


    if cornerDistanceToEdge == None:
        print("error cornerDistanceToEdge")
    else:
        #print("cornerDistancetoEdge"+cornerDistanceToEdge);
        sizePercentage = (4) * ((cornerDistanceToEdge*2)/sqrt((4**2)+(3**2)));

        #print("sizePercentage" + sizePercentage);
        sizePercentage = sizePercentage/10.24;
        #print("sizePercentage" + sizePercentage);

    return sizePercentage;


def getRandomSizeGivenMaxScale(sizePercentage: float, negativeRotationBool: bool) -> float:
     
    originalValue = sizePercentage;
    if not negativeRotationBool:
        sizePercentage = random.uniform(sizePercentage, -1)

        if sizePercentage == originalValue:
            if sizePercentage % 1 > 0.5:
                sizePercentage = int(sizePercentage) + 0.5
            else:
                sizePercentage = int(sizePercentage)
        else:
            sizePercentage = roundToHalfOrWhole(sizePercentage, negativeRotationBool)
    else:
        sizePercentage = random.uniform(1, sizePercentage)

        if sizePercentage == originalValue:
            if sizePercentage % 1 < -0.5:
                sizePercentage = int(sizePercentage) - 0.5
            else:
                sizePercentage = int(sizePercentage)


    return sizePercentage;


