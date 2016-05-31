require 'spec_helper'

describe Verhoeff do
  # before do
  #   @object = Object.new
  #   @object.extend(Verhoeff)
  # end
  
  it 'has a version number' do
    expect(Verhoeff::VERSION).not_to be nil
  end

  it 'has a valid calcsum' do
    expect(Verhoeff.calcsum(75872)).to eq(2)
    expect(Verhoeff.calcsum(12345)).to eq(1)
    expect(Verhoeff.calcsum(8473643095483728456789)).to eq(2)
  end

  it 'has a valid checksum' do
    expect(Verhoeff.checksum(758722)).to eq(0)
    expect(Verhoeff.checksum(123451)).to eq(0)
    expect(Verhoeff.checksum(84736430954837284567892)).to eq(0)
  end

  it 'generate numbers' do
    expect(Verhoeff.generate(0)).to eq(4)
    expect(Verhoeff.generate(1)).to eq(15)
    expect(Verhoeff.generate(1_000_000)).to eq(10000006)
    expect(Verhoeff.generate(1_000_001)).to eq(10000010)
    expect(Verhoeff.generate(1_000_002)).to eq(10000023)
    expect(Verhoeff.generate(12345)).to eq(123451)
  end

  it 'check a valid number' do
    expect(Verhoeff.validate(123451)).to eq(TRUE)
    expect(Verhoeff.validate(122451)).to eq(FALSE)
    expect(Verhoeff.validate(128451)).to eq(FALSE)
  end
end
