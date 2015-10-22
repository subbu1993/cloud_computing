module NutritionHelper
  def rand_sum(n = 4)
   arr = (n - 1).times.reduce([]) do |a, _|
     curr_max = 100 - a.reduce(0, :+)
     a << rand(0..curr_max)
   end

   arr << 100 - arr.reduce(0, :+)
   return arr
 end

end
