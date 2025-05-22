function setup() {
    document.title = "All Shapes";
    canvas = createCanvas(1024, 768);
    CenterCanvas();
    background(0);

    let rotation = random(-89.5, 90);
    let negativeRotationBool;
    // Check if the rotation is positive or negative
    if (rotation < 0) {
        negativeRotationBool = true;
    } else {
        negativeRotationBool = false;
    }

    rotation = RoundToHalfOrWhole(rotation, negativeRotationBool);

    const maxScaleGivenRotation = GetMaxScaleGivenRotation(rotation, negativeRotationBool, canvas.height)
    let selectedScale = GetRandomSizeGivenMaxScale(maxScaleGivenRotation, negativeRotationBool);

    let rect_width = (canvas.width / 100) * selectedScale;
    let rect_height = (canvas.height / 100) * selectedScale;
    const areaSize = rect_width * rect_height;

    const widestAspectRatio = GetWidestAspectRatio(areaSize, rotation, negativeRotationBool);
    const randomAspectRatio = GetRandomAspectRatio(rect_width, widestAspectRatio.rectWidth, areaSize, negativeRotationBool, rotation);

    rect_width = randomAspectRatio.newWidth;
    rect_height = randomAspectRatio.newHeight;

    // Make the numbers into ints so they can be used as pixel coordinates
    rect_width = int(rect_width);
    rect_height = int(rect_height);


    push();

    translate(canvas.width / 2.0, canvas.height / 2.0);
    rotate(radians(rotation));

    rectMode(CENTER);
    noStroke();
    fill(255, 0, 0);
    rect(0, 0, rect_width, rect_height);

    pop();

    let numOfPartitions = getNumOfPartitions(rect_width, rect_height, rotation, false);
    console.log(numOfPartitions);

}

function draw() {
    // background(0);
}
