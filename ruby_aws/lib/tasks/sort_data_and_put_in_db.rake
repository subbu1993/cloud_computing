desc "Read the food file and store things in db"
task :sort_food_and_store => :environment do
  foodFile =  File.new((Rails.root.join("public","food_list_1000.txt")),"r")
  all_foods = foodFile.readlines
  all_foods.each do |food|
    food_item = FoodInfo.new
    food_item.name = food
    food_item.save
  end
end
