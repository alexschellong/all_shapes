import tkinter
import math

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

def draw_square(points: list[tuple[float, float]], color: str, Canvas = None):
    Canvas.create_polygon(points, fill=color)