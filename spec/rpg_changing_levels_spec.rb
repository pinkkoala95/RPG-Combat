require './rpg_combat.rb'


describe "Changing_level" do
    before (:each) do
        @Character1 = Character.new
    end

    it 'should be able to count damage points' do
        @Character1.receive_damage_from_lower_level()
        expect(@Character1).to have_attributes(:damage_tally => 50)
    end

    it 'should change level when we hit 1000 damage points' do
        @Character1.damage_tally = 1000
        @Character1.update_level(@Character1)
        expect(@Character1).to have_attributes(:level => 2)
    end

    it 'should change from level 2 to level 3 when we hit 3000 damage points' do
        @Character1.level = 2
        @Character1.damage_tally = 3000
        @Character1.update_level(@Character1)
        expect(@Character1).to have_attributes(:level => 3)
    end

    it 'should change from level 3 to level 4 when we hit 6000 damage points' do
        @Character1.level = 3
        @Character1.damage_tally = 6000
        @Character1.update_level(@Character1)
        expect(@Character1).to have_attributes(:level => 4)
    end

    it 'should change from level 8 to level 9 when we hit 36000 damage points' do
        @Character1.level = 8
        @Character1.damage_tally = 36000
        @Character1.update_level(@Character1)
        expect(@Character1).to have_attributes(:level => 9)
    end
end