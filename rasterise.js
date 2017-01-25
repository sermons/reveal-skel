// Derived from phantomjs example rasterize.js
// https://github.com/ariya/phantomjs/blob/master/examples/rasterize.js

var page = require('webpage').create();
var system = require('system');
var Usage =
    'Usage:' + system.args[0] + 'URL [filename] [width] [height]\n' +
    '  defaults: output.pdf 1024 768';

if (system.args.length < 2 || system.args.length > 6) {
    console.log(Usage);
    phantom.exit(1);
}

var URL = system.args[1];
var output = system.args[2] ? system.args[2] : 'output.pdf';
var pageW = system.args[3] ? parseInt(system.args[3],10) : 1024;
var pageH = system.args[4] ? parseInt(system.args[4],10) :  768;
page.zoomFactor = 1.0

console.log('Saving', URL, 'to', output,
    'at', pageW, 'x', pageH);

page.viewportSize = { width: pageW, height: pageH };

if (output.substr(-4) === '.pdf') {
    page.paperSize = { width: pageW, height: pageH, margin: 0 }
}

console.log('Wait 10 sec for render ...');

page.open(URL, function (status) {
    if (status !== 'success') {
        console.log('Unable to load the address!');
        phantom.exit(1);
    } else {
        window.setTimeout(function () {
            console.log('... render done.');
            page.render(output);
            phantom.exit(0);
        }, 10000);
    }
});

