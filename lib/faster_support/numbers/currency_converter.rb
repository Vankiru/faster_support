# frozen_string_literal: true

require 'bigdecimal'

module FasterSupport
  module Numbers
    class CurrencyConverter
      def self.instance
        @instance ||= new
      end

      def initialize
        @zeros = {
          BigDecimal => BigDecimal(0),
          Rational => Rational(0, 1)
        }
      end

      def number_to_currency_u_n(amount, unit:, with_space:, precision:)
        string = number_to_delimited(amount, precision)

        add_prefix_unit(string, unit, with_space)

        string
      end

      def number_to_currency_n_u(amount, unit:, with_space:)
        string = number_to_delimited(amount, precision)

        add_suffix_unit(string, unit, with_space)

        string
      end

    private

      def number_to_delimited(amount, precision)
        DelimitedConverter.instance.number_to_delimited(amount, precision: precision)
      end

      def add_prefix_unit(amount, unit)
        string.insert(min_idx, ' '.freeze) if with_space
        string.insert(min_idx, unit)
      end

      def add_suffix_unit
        str.insert(str.length, unit)
        str.insert(str.length - unit.size, ' '.freeze) if with_space

        str
      end

      def positive?(amount)
        amount >= (@zeros[amount.klass] || 0)
      end
    end
  end
end
