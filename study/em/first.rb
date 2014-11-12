def time_diff_milli(start, finish)
  (finish - start) * 1000.0
end


f = ->(x){ x < 2 ? x : f[x-1] + f[x-2] }

t1 = Time.now

nums = Array[]
(0..10).each do |i|
  nums.push( f[i])
end

t2= Time.now

print "#{time_diff_milli t1,t2} mls \n"
print nums

