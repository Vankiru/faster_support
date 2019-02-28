require 'benchmark'
require 'memory_profiler'

require 'active_support/all'
require 'action_view/helpers'

def helper
  @helper ||= Class.new do
    include ActionView::Helpers::NumberHelper
  end.new
end

def test_memory_usage
  currency_iso = 'USD'.freeze
  amount = 97_465_732.57389
  #amount = -54_537_776_871.47523
  #amount = 37_776_871.47523

  decimal = BigDecimal(amount.to_s)
  float = amount.to_f
  rational = amount.to_r
  integer = amount.to_i
  negative = -amount

  decimal_profiler = MemoryProfiler.report do
    helper.number_to_currency(decimal, unit: currency_iso, format: "%u %n")
  end

  float_profiler = MemoryProfiler.report do
    helper.number_to_currency(float, unit: currency_iso, format: "%u %n")
  end

  rational_profiler = MemoryProfiler.report do
    helper.number_to_currency(rational, unit: currency_iso, format: "%u %n")
  end

  integer_profiler = MemoryProfiler.report do
    helper.number_to_currency(integer, unit: currency_iso, format: "%u %n")
  end

  negative_profiler = MemoryProfiler.report do
    helper.number_to_currency(negative, unit: currency_iso, format: "%u %n")
  end

  puts "\nMemory Allocated | Memory Retained"
  puts "decimal:  #{decimal_profiler.total_allocated_memsize} | #{decimal_profiler.total_retained_memsize}"
  puts "float:    #{float_profiler.total_allocated_memsize} | #{float_profiler.total_retained_memsize}"
  puts "rational: #{rational_profiler.total_allocated_memsize} | #{rational_profiler.total_retained_memsize}"
  puts "integer:  #{integer_profiler.total_allocated_memsize} | #{integer_profiler.total_retained_memsize}"
  puts "negative: #{negative_profiler.total_allocated_memsize} | #{negative_profiler.total_retained_memsize}"
end

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
        helper.number_to_currency(decimal, unit: currency_iso, format: "%u %n")
      end
    end

    benchmark.report('float:') do
      iterations.times do
        helper.number_to_currency(float, unit: currency_iso, format: "%u %n")
      end
    end

    benchmark.report('rational:') do
      iterations.times do
        helper.number_to_currency(rational, unit: currency_iso, format: "%u %n")
      end
    end

    benchmark.report('integer:') do
      iterations.times do
        helper.number_to_currency(integer, unit: currency_iso, format: "%u %n")
      end
    end

    benchmark.report('negative:') do
      iterations.times do
        helper.number_to_currency(negative, unit: currency_iso, format: "%u %n")
      end
    end
  end
end
