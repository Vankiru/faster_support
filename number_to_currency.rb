require "bigdecimal"

def number_to_currency(amount, iso)
  string = case amount
           when Integer    then integer_to_string(amount)
           when Float      then float_to_string(amount)
           when Rational   then rational_to_string(amount)
           when BigDecimal then decimal_to_string(amount)
           else raise
           end

  delimitize(string, amount)
  add_currency_iso(string, amount, iso)

  string
end

def integer_to_string(amount)
  String(amount).insert(-1, '.00'.freeze)
end

# It works incorrect with float numbers
# that have at least more than 15 digits 
# of its integer part.
def float_to_string(amount)
  add_trailing_zero(String(amount.round(2)))
end

def rational_to_string(amount)
  string = String(amount.to_i)

  string.insert(-1, '.'.freeze)
  string.insert(-1, rational_fraction(amount))

  string
end

# This method of finding the fraction part of
# a rataional number becomes less effective as
# the size of the denominator gets bigger.
# In this case transforming to a decimal number
# uses less memory.
def rational_fraction(amount)
  fraction = 0

  remainder = amount.numerator % amount.denominator

  3.times do
    number = remainder * 10

    integer = number / amount.denominator
    remainder = number % amount.denominator

    fraction = fraction * 10 + integer
  end

  if fraction % 10 >= 5
    fraction = fraction / 10 + 1
  else
    fraction /= 10
  end

  String(fraction)
end

def decimal_to_string(amount)
  add_trailing_zero( amount.round(2).to_s('F'.freeze) )
end

def add_trailing_zero(string)
  dot_index = string.index('.'.freeze)

  if string.size - 2 == dot_index 
    string.insert(-1, '0'.freeze)
  end

  string
end

def delimitize(string, amount)
  offset = positive?(amount) ? 0 : 1
  index = -7

  while offset - index <= string.size do
    string.insert(index, ','.freeze)
    index -= 4
  end
end

def add_currency_iso(string, amount, iso)
  index = positive?(amount) ? 0 : 1

  string.insert(index, ' '.freeze)
  string.insert(index, iso)
end

def positive?(amount)
  case amount
  when BigDecimal
    amount.sign >= 0
  when Rational
    (amount.numerator >= 0 && amount.denominator > 0) ||
      (amount.numerator <= 0 && amount.denominator < 0)
  else
    amount >= 0
  end
end
