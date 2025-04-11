import random
import tkinter as tk
from math import sin,radians, sqrt



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



import math

root = tk.Tk()
root.title("All Shapes")
root.geometry("1074x818")

WIDTH = 1074
HEIGHT = 818


canvas = tk.Canvas(root, 
                  width=WIDTH, 
                  height=HEIGHT,
                  bg="black") 
canvas.place(x=(1074/2.0)-(WIDTH/2.0), y=(818/2.0)-(HEIGHT/2.0))


rotation = random.uniform(-89.5, 90)

rect1_width = 1024


top_left_x = (WIDTH - rect1_width) / 2.0

rect1_height = 768



top_left_y = (HEIGHT - rect1_height) / 2.0

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
        sizePercentage = roundToHalf(sizePercentage,negativeRotationBool)
        #print("sizePercentage" + sizePercentage);

    return sizePercentage;


canvas.create_rectangle(top_left_x, top_left_y, top_left_x + rect1_width, top_left_y + rect1_height, outline="red")




if rotation < 0:
    negativeRotationBool = True












else:
    negativeRotationBool = False














rotation = roundToHalf(rotation, negativeRotationBool);

def getRandomSizeGivenMaxScale(sizePercentage: float, negativeRotationBool: bool) -> float:
     
    if negativeRotationBool:

        sizePercentage = random.uniform( sizePercentage, -1);
        
    else:
        sizePercentage = random.uniform(1, sizePercentage);


    sizePercentage = roundToHalf(sizePercentage, negativeRotationBool);

    return sizePercentage

maxScaleGivenRotation = getMaxScaleGivenRotation(rotation,negativeRotationBool,rect1_height)


rect_width = (rect1_width/100) * maxScaleGivenRotation
rect_height = (rect1_height/100) * maxScaleGivenRotation


selectedScale = getRandomSizeGivenMaxScale(rotation,negativeRotationBool)

# Calculate the center position
center_x = WIDTH / 2.0 
center_y = (HEIGHT / 2.0) 

def draw_square(points: list[tuple[float, float]], color: str, Canvas = None):
    Canvas.create_polygon(points, fill=color)


half_width = rect_width / 2.0










half_height = rect_height / 2.0


x1 = (center_x - half_width, center_y - half_height)
x2 = (center_x + half_width, center_y - half_height)
x3 = (center_x + half_width, center_y + half_height)
x4 = (center_x - half_width, center_y + half_height)
vertices = [x1,x2,x3,x4]

def rotate(points: list[tuple[float, float]], angle: float, center: tuple[float, float]) -> list[tuple[float, float]]:
    angle = math.radians(angle)
    cos_val = math.cos(angle)
    sin_val = math.sin(angle)
    cx, cy = center
    new_points = []
    for x_old, y_old in points:
        x_old -= cx
        y_old -= cy
        x_new = x_old * cos_val - y_old * sin_val
        y_new = x_old * sin_val + y_old * cos_val
        new_points.append([x_new + cx, y_new + cy])
    return new_points


vertices = rotate(vertices,rotation,(center_x,center_y))
draw_square(vertices, "blue", canvas)


root.mainloop()
