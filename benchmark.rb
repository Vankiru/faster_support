require 'benchmark'

require './number_to_currency'

def test_time
  currency_iso = 'USD'.freeze
  amount = 97_465_732.57389
  #amount = -54_537_776_871.47523
  #amount = 37_776_871.47523

  decimal = BigDecimal(amount.to_s)
  float = amount.to_f
  rational = amount.to_r
  integer = amount.to_i
  negative = -amount

  iterations = 1_000_000

  Benchmark.bm(10) do |benchmark|
    benchmark.report('decimal:') do
      iterations.times do
        number_to_currency(decimal, currency_iso) 
      end
    end

    benchmark.report('float:') do
      iterations.times do
        number_to_currency(float, currency_iso) 
      end
    end

    benchmark.report('rational:') do
      iterations.times do
        number_to_currency(rational, currency_iso) 
      end
    end

    benchmark.report('integer:') do
      iterations.times do
        number_to_currency(integer, currency_iso) 
      end
    end

    benchmark.report('negative:') do
      iterations.times do
        number_to_currency(negative, currency_iso) 
      end
    end
  end
end
