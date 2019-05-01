require 'rails_helper'

RSpec.describe Foodrecord, type: :model do
  before do
    @foodrecord = FactoryBot.create(:foodrecord)
  end
  describe 'validate' do
    describe 'store_name' do
      context '店名が未入力の場合' do
        it 'エラーを返す' do
          @foodrecord.store_name = nil
          expect(@foodrecord).not_to be_valid
        end
      end
    end

    describe 'menu_name' do
      context 'メニューが未入力の場合' do
        it 'エラーを返す' do
          @foodrecord.menu_name = nil
          expect(@foodrecord).not_to be_valid
        end
      end
    end
  end

  describe '#food_search' do
    it '1件返る' do
      expect(Foodrecord.food_search(lineuser_id:"lineuser_id",store_name:"store_name",menu_name:"menu_name",taste:"taste",thickness:"thickness",hardness:"hardness",taste_intensity:"taste_intensity",evalute:0.5).count).to eq(1)
    end
  end
end
