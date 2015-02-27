_linerase = (require '../lib/soapHelpers')._linerase
_cropName = (require '../lib/soapHelpers')._cropName
assert = require 'assert'
parseString = (require 'xml2js').parseString

describe 'linerase function', () ->
  it 'should handle tag', (done) ->
    parseString '<a><b>text</b><c>text</c></a>', (err, result) ->
      assert.deepEqual _linerase(result), {
        a: {
          b: 'text'
          c: 'text'
        }
      }
      done()

  it 'should handle multiply tags', (done) ->
    parseString '<a><b>text</b><b>text</b></a>', (err, result) ->
      assert.deepEqual _linerase(result), {
        a: {
          b: [
            'text'
            'text'
          ]
        }
      }
      done()

  it 'should handle multiply tags deeply', (done) ->
    parseString '<a><b><c>text</c><d>t</d></b><b><c>text</c><d>t</d></b></a>', (err, result) ->
      assert.deepEqual _linerase(result), {
        a: {
          b: [
            {c: 'text', d: 't'}
            {c: 'text', d: 't'}
          ]
        }
      }
      done()

  it 'should deals with numbers', () ->
    assert.deepEqual _linerase({a: '34.23'}), {a: 34.23}

  it 'should deals with datetime and not converts it to number', () ->
    assert.deepEqual _linerase({a: '2015-01-20T16:33:03Z'}), {a: '2015-01-20T16:33:03Z'}