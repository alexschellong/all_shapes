suite('Utility Functions', function () {
    let myp5;

    setup(function (done) {
        new p5(function (p) {
            p.setup = function () {
                myp5 = p;
                done();
            };
        });
    });

    teardown(function () {
        myp5.remove();
    });

    suite('RoundToHalfOrWhole', function () {
        test('positive values', function () {

            const testCases = [
                { input: 89.5, expected: 89.5 },
                { input: 89.4, expected: 89.5 },
                { input: 34.75, expected: 35.0 },
                { input: 34.73, expected: 34.5 },
                { input: 79.25, expected: 79 },
                { input: 79.23, expected: 79 },
                { input: 0, expected: 0 }
            ];

            testCases.forEach(({ input, expected }) => {
                test(`should round ${input} to ${expected}`, () => {
                    const output = RoundToHalfOrWhole(input, false);
                    expect(output).to.equal(expected);
                });
            });

        });

        test('negative values', function () {
            const testCases = [
                { input: -89.5, expected: -89.5 },
                { input: -89.4, expected: -89.5 },
                { input: -34.75, expected: -35.0 },
                { input: -34.73, expected: -34.5 },
                { input: -79.25, expected: -79 },
                { input: -79.23, expected: -79 },
                { input: 0, expected: 0 }
            ];

            testCases.forEach(({ input, expected }) => {
                test(`should round ${input} to ${expected}`, () => {
                    const output = RoundToHalfOrWhole(input, true);
                    expect(output).to.equal(expected);
                });
            });

        });

    });

});