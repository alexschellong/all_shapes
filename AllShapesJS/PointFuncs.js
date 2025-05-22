function getNumOfPartitions(rect_width, rect_height, rotation, visualizePartitions) {

    let r, g, b;

    // take away 1 pixel from each side to account for missing pixels in case of  rotation
    let density = pixelDensity();
    let rectPartitioned = createGraphics(rect_width - 2 * density, rect_height - 2 * density);
    rectPartitioned.loadPixels();
    let widthInPixels = (rectPartitioned.width * density) * 4;

    const oneWholePixel = 4 * density;
    let numOfPartitions = 0;
    // Loop through every 5th pixel of the height of the rectangle (because one partition is 5x5 pixels)
    // multiplied by the density to get the actual number of pixels
    // + (2 * density) to account for that there can be 2 pixels outside of the canvas
    for (let i = 0; i < rectPartitioned.height * density + (2 * density); i += 5 * density) {

        // Loop through every 5th pixel of the width of the rectangle 
        // by multiplying 5 by 4 and the density to get the actual number of pixels (every pixel has R,G,B,A values = 4 )
        // + 2 * oneWholePixel to account for that there can be 2 pixels outside of the canvas
        for (let j = widthInPixels * i; j < (widthInPixels * i) + widthInPixels + (2 * oneWholePixel); j += 5 * oneWholePixel) {

            // if (visualizePartitions) {
            // Get random color
            r = Math.floor(Math.random() * 256);
            g = Math.floor(Math.random() * 256);
            b = Math.floor(Math.random() * 256);
            // }


            // Check if there is enough space in the row for one more partition
            // if its less than 3 pixels do not start another partition

            let pixelsUntilEndOfLine = ((widthInPixels * i) + widthInPixels) - (j - (2 * oneWholePixel));
            let end;

            if (pixelsUntilEndOfLine < 5 * oneWholePixel) {
                if (pixelsUntilEndOfLine > 2 * oneWholePixel) {
                    end = j + pixelsUntilEndOfLine - (2 * oneWholePixel);
                } else {
                    break;
                }
            } else {
                end = j + (3 * oneWholePixel);
            }

            // Check if there is enough space for one more partition in the column for another partition
            // if its less than 3 pixels do not start another partition
            let pixelsUntilEndOfCol = (rectPartitioned.height * density) - i + (2 * density);
            let end2;

            if (pixelsUntilEndOfCol < 5 * density) {

                if (pixelsUntilEndOfCol < 3 * density) {

                    break;
                }

                end2 = pixelsUntilEndOfCol;
                numOfPartitions++;

            } else {

                // make the first row partitions only 3 pixels high
                if (i === 0) {
                    end2 = (3 * density)
                } else {
                    end2 = (5 * density)
                }
                numOfPartitions++;

            }

            // Loop through the pixels of the partition
            // by going back from the center of partition by 2 pixels
            // and changing the color of all the pixels in the partition
            for (let k = j - (2 * oneWholePixel); k < end; k += oneWholePixel) {

                // If the pixel is the first pixel of the row do not go back 2 pixels
                if (j === widthInPixels * i & k === j - (2 * oneWholePixel)) {
                    k = j;
                }

                // Set the subpixels for the whole column of the partition of the current subpixel to the same color
                for (let l = 0; l < end2; l++) {


                    let substractWidth = k - (widthInPixels * (i));
                    let addToTheNextLine = widthInPixels * (i + l - (2 * density));

                    if (i === 0) {
                        substractWidth = k - (widthInPixels * i);
                        addToTheNextLine = widthInPixels * (i + l);
                    }

                    // if (visualizePartitions) {
                    // set 1st horizontal sub pixel
                    rectPartitioned.pixels[(addToTheNextLine + (substractWidth))] = r;     // R
                    rectPartitioned.pixels[(addToTheNextLine + (substractWidth)) + 1] = g; // G
                    rectPartitioned.pixels[(addToTheNextLine + (substractWidth)) + 2] = b;   // B
                    rectPartitioned.pixels[(addToTheNextLine + (substractWidth)) + 3] = 255; // A

                    // set 2nd horizontal sub pixel
                    rectPartitioned.pixels[(addToTheNextLine + (substractWidth)) + 4] = r;     // R
                    rectPartitioned.pixels[(addToTheNextLine + (substractWidth)) + 5] = g; // G
                    rectPartitioned.pixels[(addToTheNextLine + (substractWidth)) + 6] = b;   // B
                    rectPartitioned.pixels[(addToTheNextLine + (substractWidth)) + 7] = 255; // A
                    // }

                }
            }
        }
    }

    if (visualizePartitions) {
        rectPartitioned.updatePixels();
        push();
        imageMode(CENTER);
        translate(canvas.width / 2.0, canvas.height / 2.0);
        rotate(radians(rotation));
        image(rectPartitioned, 0, 0);

        pop();
    }

    // This is noniterative way to get the number of partitions
    // let x = ((rect_width - 3 - (2 * density)) / 5) + 1;
    // x = int(x);
    // if ((rect_width - 3 - (2 * density)) % 5 > 2) {
    //     x = x + 1;
    // }
    // let y = ((rect_height - 3 - (2 * density)) / 5) + 1;
    // y = int(y);
    // if ((rect_height - 3 - (2 * density)) % 5 > 2) {
    //     y = y + 1;
    // }
    // console.log(x, y);
    // console.log(x * y);


    return numOfPartitions;


}