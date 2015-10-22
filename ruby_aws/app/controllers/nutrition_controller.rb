class NutritionController < ApplicationController
  include NutritionHelper
  def show
    @passed_in = params[:q]
    numbers = rand_sum 4
    @numbers_0 = numbers[0]
    @numbers_1 = numbers[1]
    @numbers_2 = numbers[2]
    @numbers_3 = numbers[3]

  end

end
