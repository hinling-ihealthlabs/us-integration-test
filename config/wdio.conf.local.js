'use strict'
const base = require('./wdio.conf.base.js');
exports.config = Object.assign(base.config, {
  host: 'localhost',
  port: 4444,
  capabilities: [{
    browserName: 'firefox',
    firefox_profile: {
      'security.insecure_password.ui.enabled': false,
      'security.insecure_field_warning.contextual.enabled': false
    }
    //browserName: 'internet explorer'
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