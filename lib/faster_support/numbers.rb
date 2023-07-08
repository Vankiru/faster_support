# frozen_string_literal: true

require 'faster_support/numbers/options'

require 'faster_support/numbers/delimited_converter'
require 'faster_support/numbers/rounded_converter'
require 'faster_support/numbers/currency_converter'

module FasterSupport
  module Numbers
    class << self
      def number_to_delimited(number, options = {})
        DelimitedConverter.instance.convert(number, options)
      end

      def number_to_rounded(number, options = {})
        RoundedConverter.instance.convert(number, options)
      end

      def number_to_currency_n_u(number, options = {})
        CurrencyConverter.instance.convert(number, options)
      end
    end
  end
end
