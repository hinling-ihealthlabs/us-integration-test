'use strict'
const base = require('./wdio.conf.base.js');
exports.config = Object.assign(base.config, {
  host: '52.41.120.147',
  port: 32769,
  capabilities: [{
    //browserName: 'firefox'
    browserName: 'internet explorer',
    requireWindowFocus: true
  }],
  baseUrl: 'http://web.bettercare.dev.ihealthnext.com',
  reporters: ['spec', 'junit'],
  reporterOptions: {
    outputDir: './results',
    outputFileFormat: function(opts) { // optional
      return `results.${opts.capabilities}.${opts.cid}.xml`
    }
  },
});