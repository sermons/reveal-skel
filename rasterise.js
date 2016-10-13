// Derived from phantomjs example rasterize.js
// https://github.com/ariya/phantomjs/blob/master/examples/rasterize.js

var page = require('webpage').create(),
    system = require('system'),
    address, output, paper, pageW, pageH, size;

if (system.args.length < 3 || system.args.length > 5) {
    console.log('Usage: rasterize.js URL filename [paperwidth*paperheight|paperformat] [zoom]');
    console.log('  paper: e.g., "1024px*768px" (default), "1920px*1080px", "800px" (4:3 aspect)');
    console.log('  PDF paper: e.g., "10cm*15cm", "Letter", "A4"');
    phantom.exit(1);
} else {
    address = system.args[1];
    output = system.args[2];
    paper = '1024px*768px';
    pageW = '1024px';
    pageH = '768px';
    if (system.args.length > 3) {
        paper = system.args[3];
    }

    if (paper.indexOf('*') > -1) {
        size = paper.split('*');
        pageW = parseInt(size[0], 10);
        pageH = parseInt(size[1], 10);
    } else if (output.substr(-4) === ".pdf") {
        console.log('PDF paper size:', paper);
        page.paperSize = { format: paper, orientation: 'portrait', margin: '1cm' };
    } else {
        pageW = parseInt(size, 10);
        pageH = Math.round(pageW * 3/4);
    }

    console.log('Page size:', pageW, 'x', pageH);
    page.viewportSize = { width: pageW, height: pageH };
    page.clipRect = { top: 0, left: 0, width: pageW, height: pageH };

    if (system.args.length > 4) {
        page.zoomFactor = system.args[4];
        console.log('Zoom:', page.zoomFactor);
    }

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

