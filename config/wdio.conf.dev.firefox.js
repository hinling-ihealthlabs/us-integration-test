'use strict'
const base = require('./wdio.conf.base.js');
exports.config = Object.assign(base.config, {
  host: '34.214.117.20',
  port: 32769,
  capabilities: [{
      browserName: 'firefox',
      firefox_profile: 'default'
    }
  ],
  baseUrl: 'http://web.bettercare.dev.ihealthnext.com',
  reporters: ['spec', 'junit'],
  reporterOptions: {
    outputDir: './results',
    outputFileFormat: function(opts) { // optional
      return `results.${opts.capabilities}.${opts.cid}.xml`
    }
  },
});