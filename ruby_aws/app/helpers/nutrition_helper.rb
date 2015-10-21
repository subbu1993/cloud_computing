module NutritionHelper
  def rand_sum(n = 2)
   arr = (n - 1).times.reduce([]) do |a, _|
     curr_max = self - a.reduce(0, :+)
     a << rand(0..curr_max)
   end

   arr << self - arr.reduce(0, :+)
 end

end
