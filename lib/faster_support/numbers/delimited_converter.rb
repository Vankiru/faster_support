# frozen_string_literal: true

require 'bigdecimal'

module FasterSupport
  module Numbers
    class DelimitedConverter
      def self.instance
        @instance ||= new
      end

      def initialize
        @zeros = {
          BigDecimal => BigDecimal(0),
          Rational => Rational(0, 1)
        }
      end

      def number_to_delimited(amount, precision:)
        precision ||= 2

        string = number_to_string(amount, precision)
        delimitize(string, precision)

        string
      end

    private

      def number_to_string(amount, precision)
        case amount
          when Integer    then integer_to_string(amount, precision)
          when Float      then float_to_string(amount, precision)
          when Rational   then rational_to_string(amount, precision)
          when BigDecimal then decimal_to_string(amount, precision)
          else raise ArgumentError.new('amount should be numeric')
        end
      end

      def integer_to_string(amount, precision)
        sprintf('%d.00'.freeze, amount)
      end

      # It works incorrect with float numbers
      # that have more than 15 digits
      # of its integer part.
      # Float#round can return incorrect value.
      def float_to_string(amount, precision)
        sprintf('%.2f'.freeze, amount.round(precision))
      end

      # format BigDecimal as string to avoid a large string allocation
      def decimal_to_string(amount, precision)
        str = amount.to_s('F'.freeze)
        dot_idx = str.rindex('.'.freeze)
        frac_length = str.length - dot_idx - 1

        if frac_length == 1
          # put the second zero after . if there is only one
          str.insert(-1, '0'.freeze)
        elsif frac_length == 2
          str
        else
          round_string(str, dot_idx)
        end
      end

      def round_string(str, dot_idx = nil)
        # do round manually to support rounding as in ActiveSupport
        # b/c of inconsistency of rounding rules in Ruby https://bugs.ruby-lang.org/issues/12548
        dot_idx ||= str.rindex('.'.freeze)
        if str.getbyte(dot_idx+3) >= 53 # '5'
          idx = dot_idx + 2
          while true do
            if idx < 0
              str.insert(0, '1'.freeze)
              dot_idx += 1
              break
            end
            code = str.getbyte(idx)
            case code
            when 57 # '9'
              str.setbyte(idx, 48) # '0'
              idx -= 1
            when 46 # '.'
              idx -= 1
            when 45 # '-'
              str.insert(1, '1'.freeze)
              dot_idx += 1
              break
            else
              str.setbyte(idx, code+1)
              break
            end
          end
        end
        str[0, dot_idx+3]
      end

      def rational_to_string(amount, precision)
        integer = amount.to_i
        frac3 = (amount.numerator % amount.denominator)*1000 / amount.denominator
        fraction = frac3 / 10

        last_digit = frac3 % 10
        fraction += 1 if last_digit >= 5

        if fraction == 100
          integer += 1
          fraction = 0
        end

        sprintf('%d.%02d'.freeze, integer, fraction)
      end

      def delimitize(amount, precision)
        min_idx = (amount < zero(amount.class)) ? 1 : 0
        # 3 chars from the end to the dot and another 3 chars to the first delimeter position
        idx = str.length - precision - 4

        while idx > min_idx
          str.insert(idx, ','.freeze)
          idx -= 3
        end
      end

      def positive?(amount)
        amount >= (@zeros[amount.klass] || 0)
      end
    end
  end
end
