// Derived from phantomjs example rasterize.js
// https://github.com/ariya/phantomjs/blob/master/examples/rasterize.js

var page = require('webpage').create(),
    system = require('system'),
    address, output, paper, pageW, pageH, size;

if (system.args.length < 3 || system.args.length > 5) {
    console.log('Usage: rasterize.js URL filename [paperwidth*paperheight|paperformat] [zoom]');
    console.log('  paper (pdf output) examples: "5in*7.5in", "10cm*20cm", "A4", "Letter"');
    console.log('  image (png/jpg output) examples: "1920px" entire page, window width 1920px');
    console.log('                                   "800px*600px" window, clipped to 800x600');
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
    page.paperSize = { width: pageW, height: pageH, margin: '0px' };
    page.viewportSize = { width: pageW, height: pageH };
    page.clipRect = { top: 0, left: 0, width: pageW, height: pageH };

    if (system.args.length > 4) {
        page.zoomFactor = system.args[4];
        console.log('Zoom:', page.zoomFactor);
    }

    console.log('Wait 15 sec for render...');
    page.open(address, function (status) {
        if (status !== 'success') {
            console.log('Unable to load the address!');
            phantom.exit(1);
        } else {
            window.setTimeout(function () {
                page.render(output);
                phantom.exit();
            }, 15000);
        }
    });
}

