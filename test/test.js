'use strict';

const assert = require('assert');

describe('Wops', function() {
  it('Should pass this simple test', function() {
    assert.equal(42, 42);
  });

  it('Shouldn\'t hang in this one because of the apostrophe', function() {
    assert.equal('Hi bob!', 'Hi bob!');
  });

  it('Should not "hang"', function() {
    assert.equal('Hi bob!', 'Hi bob!');
  });

  it("Should not 'hang'", function() {
    assert.equal('Hi bob!', 'Hi bob!');
  });
});
