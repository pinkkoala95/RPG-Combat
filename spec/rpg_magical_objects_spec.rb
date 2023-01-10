require './rpg_combat.rb'


describe Magical_object do
    before (:each) do
        @Character1 = Character.new
        @Character2 = Character.new
        @Magical_object = Magical_object.new
    end

    
    it 'should have a class called Magical_object' do
        expect(@Magical_object).to be_a(Magical_object)
    end
    it 'should return a starting health attribute' do
        expect(@Magical_object).to have_attributes(:health => 10)
    end
    it 'should be detroyed when health is zero' do
        @Magical_object.health = 0
        expect(@Magical_object).to have_attributes(:status => "dead")
    end
end