suite('Size Functions', function () {

    suite('getMaxScaleGivenRotation', function () {
        test('positive values', function () {
            const testCases = [
                { input: 89.5, expected: 74.5 },
                { input: 89.4, expected: 74.5 },
                { input: 79.25, expected: 67 },
                { input: 79.23, expected: 67 },
                { input: 0, expected: 100 },
                { input: 10, expected: 82 }
            ];

            testCases.forEach(testCase => {
                const output = GetMaxScaleGivenRotation(testCase.input, false, 768);
                assert.equal(RoundToHalfOrWhole(output, false), testCase.expected);
            });
        });

        test('negative values', function () {
            const testCases = [
                { input: -89.5, expected: -74.5 },
                { input: -89.4, expected: -74.5 },
                { input: -79.25, expected: -67 },
                { input: -79.23, expected: -67 },
                { input: 0, expected: -100 },
                { input: -10, expected: -82 }
            ];

            testCases.forEach(testCase => {
                const output = GetMaxScaleGivenRotation(testCase.input, true, 768);

                assert.equal(RoundToHalfOrWhole(output, true), testCase.expected);
            });
        });
    });

    suite('getRandomSizeGivenMaxScale', function () {
        test('positive values', function () {
            const testCases = [74.5, 67, 100];

            testCases.forEach(maxScale => {
                const output = GetRandomSizeGivenMaxScale(maxScale, false);
                assert.isAtMost(output, maxScale);
                assert.isAtLeast(output, 1);
                assert.equal(output % 0.5, 0);
            });
        });

        test('negative values', function () {
            const testCases = [-74.5, -67, -100];

            testCases.forEach(maxScale => {
                const output = GetRandomSizeGivenMaxScale(maxScale, true);
                console.log("output:", output);
                assert.isAtLeast(output, maxScale);
                assert.isAtMost(output, -1);
                assert.equal(output % 0.5, 0);
            });
        });
    });
});