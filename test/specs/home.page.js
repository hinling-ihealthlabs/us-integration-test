var assert = require('assert');
describe('bettercare home page', function() {
  it('should have the right title', function () {
    browser.url('/');
    var title = browser.getTitle();
    assert.equal(title, 'Population Health');
  });
});

