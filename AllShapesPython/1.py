import random
from UtilFuncs import *
from SizeFuncs import *
import tkinter as tk
from TkInterFuncs import *

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

# Calculate the center position
center_x = WIDTH / 2.0 
center_y = (HEIGHT / 2.0) 

# Calculate half dimensions
half_width = rect_width / 2.0
half_height = rect_height / 2.0

# Calculate vertices before rotation (as tuples)
x1 = (center_x - half_width, center_y - half_height)
x2 = (center_x + half_width, center_y - half_height)
x3 = (center_x + half_width, center_y + half_height)
x4 = (center_x - half_width, center_y + half_height)
vertices = [x1,x2,x3,x4]

vertices = rotate(vertices,rotation,(center_x,center_y))
draw_square(vertices, "blue", canvas)

# Start the main event loop
root.mainloop()
