require "Verhoeff/version"

##
# This module represents an Verhoeff number and checksum.
module Verhoeff
  VERHOEFF_TABLE_D = [
    [0,1,2,3,4,5,6,7,8,9],
    [1,2,3,4,0,6,7,8,9,5],
    [2,3,4,0,1,7,8,9,5,6],
    [3,4,0,1,2,8,9,5,6,7],
    [4,0,1,2,3,9,5,6,7,8],
    [5,9,8,7,6,0,4,3,2,1],
    [6,5,9,8,7,1,0,4,3,2],
    [7,6,5,9,8,2,1,0,4,3],
    [8,7,6,5,9,3,2,1,0,4],
    [9,8,7,6,5,4,3,2,1,0]]
  VERHOEFF_TABLE_P = [
    [0,1,2,3,4,5,6,7,8,9],
    [1,5,7,6,2,8,3,0,9,4],
    [5,8,0,3,7,9,6,1,4,2],
    [8,9,1,6,0,4,3,5,2,7],
    [9,4,5,3,1,2,6,8,7,0],
    [4,2,8,6,5,7,3,9,0,1],
    [2,7,9,3,8,0,6,4,1,5],
    [7,0,4,6,9,1,3,2,5,8]]
  VERHOEFF_TABLE_INV = [0,4,3,2,1,5,6,7,8,9]

  def calcsum(number)
    # For a given number returns a Verhoeff checksum digit
    c = 0
    number.to_s.reverse.split('').each_with_index do |item, i|
      c = VERHOEFF_TABLE_D[c][VERHOEFF_TABLE_P[(i+1)%8][item.to_i]]
    end
    return VERHOEFF_TABLE_INV[c]
  end

  def checksum(number)
    # For a given number generates a Verhoeff digit and
    # returns number + digit
    c = 0
    number.to_s.reverse.split('').each_with_index do |item, i|
      c = VERHOEFF_TABLE_D[c][VERHOEFF_TABLE_P[i % 8][item.to_i]]
    end
    return c
  end

  def generate(number)
    # For a given number returns number + Verhoeff checksum digit
    return "#{number}#{calcsum(number)}".to_i
  end
  
  def validate(number)
    # Validate Verhoeff checksummed number (checksum is last digit)
    return checksum(number) == 0
  end
  module_function :validate, :generate, :checksum, :calcsum
end


class Fixnum
  def generate_verhoeff
    Verhoeff.generate(self)
  end

  def validate_verhoeff
    Verhoeff.validate(self)
  end
end
