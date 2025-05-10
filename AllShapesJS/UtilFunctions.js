function CenterCanvas() {
    var x = (windowWidth - width) / 2;
    var y = (windowHeight - height) / 2;
    canvas.position(x, y);
}

function WindowResized() {
    CenterCanvas();
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


function RoundToHalfOrWholeDownwards(value) {
    if (value % 1 < 0.5) {
        value = int(value);
    } else {
        value = int(value) + 0.5;
    }

    return value;
}


function RoundToOneDecimalPlaceButNotOverValue(value) {
    const originalValue = value;

    if (value == originalValue) {
        value = Math.floor(value * 10) / 10;
    } else {
        value = Math.round(value * 10) / 10;
    }

    return value;
}

// Expose the function to the global scope
window.RoundToHalfOrWhole = RoundToHalfOrWhole;
window.RoundToHalfOrWholeDownwards = RoundToHalfOrWholeDownwards;
window.RoundToOneDecimalPlaceButNotOverValue = RoundToOneDecimalPlaceButNotOverValue;


