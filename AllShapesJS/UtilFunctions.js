function CenterCanvas() {
    var x = (windowWidth - width) / 2;
    var y = (windowHeight - height) / 2;
    canvas.position(x, y);
}

function WindowResized() {
    centerCanvas();
}


function RoundToHalfOrWhole(value, negativeRotation) {
    const decimalNums = Math.abs(Math.floor((value % 1) * 100));

    if (decimalNums < 75 && decimalNums > 25) {
        if (negativeRotation) {
            value = int(value) - 0.5;
        } else {
            value = int(value) + 0.5;
        }
    } else {
        value = Math.round(value);

    }

    return value;
}

