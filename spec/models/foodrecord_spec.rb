require 'rails_helper'

RSpec.describe Foodrecord, type: :model do
  before do
    FactoryBot.create(:foodrecord)
  end
  describe '#food_search' do
    it '1件返る' do
      expect(Foodrecord.food_search(lineuser_id:"lineuser_id",store_name:"store_name",menu_name:"menu_name",taste:"taste",thickness:"thickness",hardness:"hardness",taste_intensity:"taste_intensity",evalute:0.5).count).to eq(1)
    end
  end
end
