require 'nutrition_helper'
class NutritionController < ApplicationController
  include NutritionHelper
  def show
    @passed_in = params[:q]
    @numbers = 100.rand_sum 4
  end

end
