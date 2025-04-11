import random
from UtilFuncs import *
from SizeFuncs import *
import tkinter as tk
import math


def getMaxScaleGivenRotation(rotation: float, negativeRotationBool: bool, height: int) -> float:
  
    halfHeight = height/2.0;
    cornerDistanceToEdge = None
    ratioDiagonalRotation = 216.87;

    if (not negativeRotationBool):
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

            cornerDistanceToEdge = (halfHeight/sin(radians(shapeDiagonalRotation)));

        else:
            print("error bottom --> side");


    if cornerDistanceToEdge == None:
        print("error cornerDistanceToEdge")
    else:
        #print("cornerDistancetoEdge"+cornerDistanceToEdge);
        sizePercentage = (4) * ((cornerDistanceToEdge*2)/sqrt((4**2)+(3**2)));

        #print("sizePercentage" + sizePercentage);
        sizePercentage = sizePercentage/7.68;
        sizePercentage = roundToHalf(sizePercentage,negativeRotationBool)
        #print("sizePercentage" + sizePercentage);

    return sizePercentage;


def getRandomSizeGivenMaxScale(sizePercentage: float, negativeRotationBool: bool) -> float:
     
    if negativeRotationBool:

        sizePercentage = random.uniform( sizePercentage, -1);
        
    else:
        sizePercentage = random.uniform(1, sizePercentage);


    sizePercentage = roundToHalf(sizePercentage, negativeRotationBool);

    return sizePercentage



# Rounds the floating number either to a whole number or 0.5
def  roundToHalf(value: float, negativeRotation: bool) -> float:

    decimalNums = abs(int((value % 1)*100))
        
    
    if decimalNums < 75 and decimalNums > 25:
        if negativeRotation:
            value = int(value) - 0.5
        else:
            value = int(value) + 0.5;
            
    else:
        value = int(value)
    


    return value;

def rotate(points: list[tuple[float, float]], angle: float, centre: tuple[float, float]) -> list[tuple[float, float]]:
    angle = math.radians(angle)
    cos_val = math.cos(angle)
    sin_val = math.sin(angle)
    cx, cy = centre
    new_points = []
    for x_old, y_old in points:
        x_old -= cx
        y_old -= cy
        x_new = x_old * cos_val - y_old * sin_val
        y_new = x_old * sin_val + y_old * cos_val
        new_points.append([x_new + cx, y_new + cy])
    return new_points

def draw_square(points: list[tuple[float, float]], colour: str, Canvas = None):
    Canvas.create_polygon(points, fill=colour)

root = tk.Tk()
root.title("All Shapes")
root.geometry("1074x818")

WIDTH = 1074
HEIGHT = 818

# Create a canvas
canvas = tk.Canvas(root, 
                  width=WIDTH, 
                  height=HEIGHT,
                  bg="black") 
canvas.place(x=(1074/2.0)-(WIDTH/2.0), y=(818/2.0)-(HEIGHT/2.0))

# Get a random rotation
rotation = random.uniform(-89.5, 90)

rect1_width = 1024
rect1_height = 768

# Calculate the top-left corner position
top_left_x = (WIDTH - rect1_width) / 2.0
top_left_y = (HEIGHT - rect1_height) / 2.0

# Use tkinter function to create the rectangle
canvas.create_rectangle(top_left_x, top_left_y, top_left_x + rect1_width, top_left_y + rect1_height, outline="red")



# Check if the rotation is positive or negative
if rotation < 0:
    negativeRotationBool = True
else:
    negativeRotationBool = False

rotation = roundToHalf(rotation, negativeRotationBool);

maxScaleGivenRotation = getMaxScaleGivenRotation(rotation,negativeRotationBool,rect1_height)
selectedScale = getRandomSizeGivenMaxScale(rotation,negativeRotationBool)

rect_width = (rect1_width/100) * maxScaleGivenRotation
rect_height = (rect1_height/100) * maxScaleGivenRotation

# Calculate the centre position
centre_x = WIDTH / 2.0 
centre_y = (HEIGHT / 2.0) 

# Calculate half dimensions
half_width = rect_width / 2.0
half_height = rect_height / 2.0

# Calculate vertices before rotation (as tuples)
x1 = (centre_x - half_width, centre_y - half_height)
x2 = (centre_x + half_width, centre_y - half_height)
x3 = (centre_x + half_width, centre_y + half_height)
x4 = (centre_x - half_width, centre_y + half_height)
vertices = [x1,x2,x3,x4]

vertices = rotate(vertices,rotation,(centre_x,centre_y))
draw_square(vertices, "blue", canvas)

# Start the main event loop
root.mainloop()
