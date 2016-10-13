// Derived from phantomjs example rasterize.js
// https://github.com/ariya/phantomjs/blob/master/examples/rasterize.js

var page = require('webpage').create(),
    system = require('system'),
    address, output, paper, pageW, pageH, size;

if (system.args.length < 3 || system.args.length > 6) {
    console.log('Usage: rasterize.js URL filename [width] [height] [zoom]');
    console.log('  e.g., http://example.com output.pdf 1024 768 1.0');
    phantom.exit(1);
} else {
    pageW = 1024;
    pageH =  768;
    address = system.args[1];
    output = system.args[2];
    if (system.args.length > 3) pageW = system.args[3];
    if (system.args.length > 4) pageH = system.args[4];
    if (system.args.length > 5) page.zoomFactor = system.args[5];

    page.viewportSize = { width: pageW, height: pageH };
    page.clipRect = { top: 0, left: 0, width: pageW, height: pageH };
    if (output.substr(-4) === ".pdf") {
        page.paperSize = { width: pageW, height: pageH, margin: 0 };
    }

    console.log('Saving', address, 'to', output, 'at', pageW, 'x', pageH, 'zoom', page.zoomFactor);
    console.log('Wait 10 sec for render...');
    page.open(address, function (status) {
        if (status !== 'success') {
            console.log('Unable to load the address!');
            phantom.exit(1);
        } else {
            window.setTimeout(function () {
                page.render(output);
                phantom.exit(0);
            }, 10000);
        }
    });
}

