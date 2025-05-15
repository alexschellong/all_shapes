loadPixels()
let density = pixelDensity();

let pixelHeight = 0;
let pixelWidth = 0;

let widthInPixels = (width * density) * 4;

count = 0;
let countList = [];
let countListDiff = [];
let stopBool = false;
for (let i = 0; i < height * density; i += 1) {
    if (stopBool) {
        break;
    }
    for (let j = widthInPixels * i; j < (widthInPixels * i) + widthInPixels; j += 4) {

        count = count + 1;

        if (pixels[j] > 100) {
            countList.unshift(count);
            if (countList.length > 1) {
                let x = countList[0] - countList[1];



                if (countListDiff.length > 4) {

                    if (!countListDiff.includes(x)) {
                        stopBool = true;
                        pixels[countList[1]] = 255;     // R
                        pixels[countList[1] + 1] = 0; // G
                        pixels[countList[1] + 2] = 0;   // B
                        pixels[countList[1] + 3] = 255; // A

                        break;
                    }
                    countListDiff.pop();
                }
                countListDiff.unshift(x);
            }
            pixelHeight = pixelHeight + 1;
            pixels[j] = 0;     // R
            pixels[j + 1] = 255; // G
            pixels[j + 2] = 0;   // B
            pixels[j + 3] = 255; // A
            count = 0;
            break;
        }
    }
}
pixelHeight = (pixelHeight + 1) / density;

// console.log(countList);

// for (let i = 0; i < width * density; i += 1) {
//     for (let j = i * (4); j < widthInPixels * height; j += widthInPixels) {

//         if (pixels[j] > 100) {
//             pixelWidth = pixelWidth + 1;
//             pixels[j] = 0;     // R
//             pixels[j + 1] = 0; // G
//             pixels[j + 2] = 255;   // B
//             pixels[j + 3] = 255; // A
//             break;
//         }

//     }
// }

// pixelWidth = (pixelWidth + 1) / density;

console.log(pixelHeight);
console.log(pixelWidth);