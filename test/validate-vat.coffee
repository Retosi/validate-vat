expect = require 'expect.js'
validate = require '../src/index'

describe 'validate()', ->

  # Netflix 2016 VAT Number
  it 'should return true if it is a valid VAT number', (done) ->
    validate 'NL', '853746333B01', (err, validationInfo) ->
      if err then return done err
      expect(validationInfo.valid).to.be true
      done()

  it 'should abort request if timeout is specified', (done) ->
    validate 'NL', '853746333B01', 10, (err) ->
      expect(err.code).to.be 'ECONNRESET'
      done()

  it 'should return false if it is an invalid VAT number', (done) ->
    validate 'NL', '802311783', (err, validationInfo) ->
      if err then return done err
      expect(validationInfo.valid).to.be false
      done()

  it 'should return INVALID_INPUT if the countryCode is US', (done) ->
    validate 'US', '802311782', (err, validationInfo) ->
      expect(err.message).to.be 'The provided CountryCode is invalid or the VAT number is empty'
      done()

  it 'should return INVALID_INPUT if the vatNumber is empty', (done) ->
    validate 'GB', '', (err, validationInfo) ->
      expect(err.message).to.be 'The provided CountryCode is invalid or the VAT number is empty'
      done()
