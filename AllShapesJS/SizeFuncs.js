function GetMaxScaleGivenRotation(rotation, negativeRotationBool, height) {
    const halfHeight = height / 2.0;
    let cornerDistanceToEdge = null;
    const ratioDiagonalRotation = 216.87;

    if (negativeRotationBool) {
        // negative rotation - rect touching the lower left corner 
        const shapeDiagonalRotation = ratioDiagonalRotation - rotation;
        // console.log("shapeDiagonalRotation:", shapeDiagonalRotation);

        if (shapeDiagonalRotation >= ratioDiagonalRotation) {
            // rect touching top left corner
            cornerDistanceToEdge = (halfHeight / sin(radians(shapeDiagonalRotation)));
        } else {
            console.log("error top --> side");
        }
    } else {
        // positive rotation - rect touching the lower right corner 
        const shapeDiagonalRotation = ratioDiagonalRotation + rotation;

        // console.log("shapeDiagonalRotation:", shapeDiagonalRotation);
        if (shapeDiagonalRotation >= ratioDiagonalRotation) {
            // rect touching the top 
            cornerDistanceToEdge = -(halfHeight / sin(radians(shapeDiagonalRotation)));
        } else {
            console.log("error bottom --> side");
        }
    }

    if (cornerDistanceToEdge === null) {
        console.log("error cornerDistanceToEdge");
    } else {
        let sizePercentage = 4 * ((cornerDistanceToEdge * 2) / sqrt((4 ** 2) + (3 ** 2)));

        // console.log("sizePercentage:", sizePercentage);
        sizePercentage = sizePercentage / 10.24;
        // console.log("sizePercentage:", sizePercentage);

        return sizePercentage;
    }
}

function GetRandomSizeGivenMaxScale(sizePercentage, negativeRotationBool) {
    const originalValue = sizePercentage;
    if (!negativeRotationBool) {
        sizePercentage = random(1, sizePercentage);

        if (sizePercentage == originalValue) {
            if (sizePercentage % 1 > 0.5) {
                sizePercentage = int(sizePercentage) + 0.5;
            } else {
                sizePercentage = int(sizePercentage);
            }
        } else {
            sizePercentage = RoundToHalfOrWhole(sizePercentage, negativeRotationBool);
        }
    } else {
        sizePercentage = random(sizePercentage, -1);

        if (sizePercentage == originalValue) {
            if (sizePercentage % 1 < -0.5) {
                sizePercentage = int(sizePercentage) - 0.5;
            } else {
                sizePercentage = int(sizePercentage);
            }
        } else {
            sizePercentage = RoundToHalfOrWhole(sizePercentage, negativeRotationBool);
        }
    }


    return sizePercentage;

}


function GetWidestAspectRatio(areaSize, rotation, negativeRotationBool) {

    let rectWidth;
    let rectHeight;

    if (rotation == 0) {

        if (areaSize / canvas.width < 5) {
            rectWidth = areaSize / 5.0;
            rectHeight = 5;
        } else {
            rectHeight = areaSize / canvas.height;
            rectWidth = canvas.width;
        }
    }
    else if (rotation == 90) {

        if (areaSize / canvas.height < 5) {

            rectWidth = areaSize / 5.0;
            rectHeight = 5;
        } else {
            rectHeight = areaSize / canvas.width;
            rectWidth = canvas.height;
        }
    }
    else {
        const proportionsTopBottom = GetProportionTopBottom(areaSize, rotation, negativeRotationBool);
        rectHeight = proportionsTopBottom.newBoxHeight;
        rectWidth = proportionsTopBottom.newBoxWidth;

        let z = sqrt(sq(rectWidth) + sq(rectHeight));
        let alpha = asin(rectHeight / (z));
        z = z / 2.0;
        let y;
        let x;

        if (negativeRotationBool) {
            x = z * cos(radians(rotation) + alpha);
            y = z * sin(radians(rotation) + alpha);
        } else {
            x = z * cos(radians(rotation) - alpha);
            y = z * sin(radians(rotation) - alpha);
        }

        if (abs(x) > 512) {
            const proportionsSides = GetProportionSides(areaSize, rotation, negativeRotationBool);
            rectHeight = proportionsSides.newBoxHeight;
            rectWidth = proportionsSides.newBoxWidth;

            z = sqrt(sq(rectWidth) + sq(rectHeight));
            alpha = asin(rectHeight / (z));
            z = z / 2.0;
            x = z * cos(radians(rotation) - alpha);
            y = z * sin(radians(rotation) - alpha);
        }
    }

    return { rectWidth, rectHeight };
}

function GetProportionTopBottom(areaSize, rotation, negativeRotationBool) {

    let fakeWidth;

    if (negativeRotationBool) {

        fakeWidth = canvas.height / tan(radians(-rotation));
    } else {

        fakeWidth = canvas.height / tan(radians(rotation));
    }

    const diagonal = sqrt(sq(canvas.height) + sq(fakeWidth));
    const newBoxHeightSquaredPart = 1 - sqrt(1 - 4 * (fakeWidth / canvas.height) * areaSize / sq(diagonal));
    let newBoxHeight = (diagonal * canvas.height / fakeWidth * newBoxHeightSquaredPart) / 2;

    if (newBoxHeight < 5.0) {
        newBoxHeight = 5;
    }
    const newBoxWidth = areaSize / newBoxHeight;

    return { newBoxHeight, newBoxWidth };
}


function GetProportionSides(areaSize, rotation, negativeRotation) {

    let fakeWidth;

    if (negativeRotation) {
        rotation = 45 + (45 - rotation);
        fakeWidth = canvas.width / tan(radians(-rotation));
    } else {
        rotation = 45 + (45 - rotation);
        fakeWidth = canvas.width / tan(radians(rotation));
    }

    const diagonal = sqrt(sq(canvas.width) + sq(fakeWidth));


    const newBoxHeightSquaredPart = 1 - sqrt(1 - 4 * (fakeWidth / canvas.width) * areaSize / sq(diagonal));
    const newBoxHeight = (diagonal * canvas.width / fakeWidth * newBoxHeightSquaredPart) / 2;

    if (newBoxHeight < 5.0) {
        newBoxHeight = 5;
    }

    const newBoxWidth = areaSize / newBoxHeight;


    return { newBoxHeight, newBoxWidth };
};

function GetRandomAspectRatio(startWidth, maxWidth, areaSize, negativeRotationBool) {
    let newWidth;

    if (negativeRotationBool) {
        newWidth = random(-startWidth, maxWidth);
    } else {

        newWidth = random(startWidth, maxWidth);
    }

    const newHeight = areaSize / newWidth;
    const aspectRatio = newHeight / newWidth;

    return { newWidth, newHeight, aspectRatio };;
};


// Expose the function to the global scope
window.GetMaxScaleGivenRotation = GetMaxScaleGivenRotation;
window.GetRandomSizeGivenMaxScale = GetRandomSizeGivenMaxScale;
window.GetWidestAspectRatio = GetWidestAspectRatio;
window.GetProportionTopBottom = GetProportionTopBottom;
window.GetProportionSides = GetProportionSides;
window.GetRandomAspectRatio = GetRandomAspectRatio;
