require "bigdecimal"

def number_to_currency(amount, iso)
  #number = (amount.to_f.round(2) * 100).to_i
  number = (amount.to_f * 100).round(0).to_i

  if number > 0
    string = "#{iso} #{number}"
    offset = iso.size + 1
  else
    string = "-#{iso} #{-number}"
    offset = iso.size + 2
  end

  string.insert(-3, '.')
  comma = ","; index = -7

  while offset - index <= string.size do
    string.insert(index, comma)
    index -= 4
  end

  string
end
