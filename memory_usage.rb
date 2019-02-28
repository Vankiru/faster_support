require 'memory_profiler'

require './number_to_currency'

def test_memory_usage
  currency_iso = 'USD'.freeze
  amount = 97_465_732.5
  #amount = -54_537_776_871.47523
  #amount = -4_537_776_871.47523
  #amount = BigDecimal('3248679385673845673848247562954863549673856738578637245784349768356034956839586935453777612345678912345678900.23348675698359678')

  decimal = BigDecimal(amount.to_s)
  float = amount.to_f
  rational = amount.to_r
  integer = amount.to_i
  negative = -amount

  decimal_profiler = MemoryProfiler.report do
    number_to_currency(decimal, currency_iso)
  end

  float_profiler = MemoryProfiler.report do
    number_to_currency(float, currency_iso)
  end

  rational_profiler = MemoryProfiler.report do
    number_to_currency(rational, currency_iso)
  end

  integer_profiler = MemoryProfiler.report do
    number_to_currency(integer, currency_iso)
  end

  negative_profiler = MemoryProfiler.report do
    number_to_currency(negative, currency_iso)
  end

  puts "\nMemory Allocated | Memory Retained"
  puts "decimal:  #{decimal_profiler.total_allocated_memsize} | #{decimal_profiler.total_retained_memsize}"
  puts "float:    #{float_profiler.total_allocated_memsize} | #{float_profiler.total_retained_memsize}"
  puts "rational: #{rational_profiler.total_allocated_memsize} | #{rational_profiler.total_retained_memsize}"
  puts "integer:  #{integer_profiler.total_allocated_memsize} | #{integer_profiler.total_retained_memsize}"
  puts "negative: #{negative_profiler.total_allocated_memsize} | #{negative_profiler.total_retained_memsize}"
end
