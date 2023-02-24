require './rpg_combat.rb'

describe Magical_object do
    before (:each) do
        @Character1 = Character.new
        @Character2 = Character.new
        @Magical_object = Magical_object.new
        @Healing_magical_object = Healing_magical_object.new
        @Magical_weapon = Magical_weapon.new
    end

    
    it 'should have a class called Magical_object' do
        expect(@Magical_object).to be_a(Magical_object)
    end
    it 'should return a starting health attribute' do
        expect(@Magical_object).to have_attributes(:health => 100)
    end
    it 'should be detroyed when health is zero' do
        @Magical_object.health = 0
        @Magical_object.damage_object()
        expect(@Magical_object).to have_attributes(:status => "destroyed")
    end
    it 'should not be healed by characters' do  
        @Magical_object.health = 5
        @Character1.heal_another(@Magical_object)
        expect(@Magical_object).to have_attributes(:health => 5)
    end
    it 'should return a starting health attribute' do
        expect(@Healing_magical_object).to have_attributes(:status => "alive", :health => 100)
    end

    it 'should be detroyed when health is zero' do
        @Healing_magical_object.health = 0
        @Healing_magical_object.damage_object()
        expect(@Healing_magical_object).to have_attributes(:status => "destroyed")
    end

    it 'should be able to help a character gain health' do
        @Healing_magical_object.health = 5
        @Character1.health = 900
        @Healing_magical_object.magical_giving_health(@Character1)
        expect(@Character1).to have_attributes(:health => 905)
    end

    it 'should be able to help a character gain health up to its max health' do
        @Healing_magical_object.health = 5
        @Character1.health = 1000
        @Healing_magical_object.magical_giving_health(@Character1)
        expect(@Character1).to have_attributes(:health => 1000)
    end

    it 'should be able to help a character gain up to its max health but be capped at maxiumum health' do
        @Healing_magical_object.health = 5
        @Character1.health = 996
        @Healing_magical_object.magical_giving_health(@Character1)
        expect(@Character1).to have_attributes(:health => 1000)
    end

    it 'should adjust Healing Magical Objects health depending on health given to character' do
        @Healing_magical_object.health = 5
        @Character1.health = 996
        @Healing_magical_object.magical_giving_health(@Character1)
        expect(@Healing_magical_object).to have_attributes(:health => 1, :status => "alive")
    end

    it 'should adjust Healing Magical Objects status to detroyed' do
        @Healing_magical_object.health = 5
        @Character1.health = 995
        @Healing_magical_object.magical_giving_health(@Character1)
        expect(@Healing_magical_object).to have_attributes(:health => 0, :status => "destroyed")
    end

    it 'should not be able to deal damage as a healing_magical_object' do
        @Healing_magical_object.deal_damage(@Character1)
        expect(@Character1).to have_attributes(:health => 1000)
    end

    it 'should initialize a magical weapon with fixed amount of damage it can give' do
        expect(@Magical_weapon).to have_attributes(:damage => 50)
    end

    it 'should be able to use damage on a Character' do
        @Magical_weapon.deal_damage(@Character1)
        expect(@Character1).to have_attributes(:health => 950)
    end

    it 'should reduce the health of the magical weapon by 1 everytime it deals damage' do
        @Magical_weapon.deal_damage(@Character1)
        expect(@Magical_weapon).to have_attributes(:health => 99)
    end
    
end