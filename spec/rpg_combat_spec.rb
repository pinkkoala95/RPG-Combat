require './rpg_combat.rb'


describe Character do
    before (:each) do
        @Character1 = Character.new
        @Character2 = Character.new
    end

    
    it 'should have a class called Character' do
        expect(@Character1).to be_a(Character)
    end
    it 'should return a starting health attribute of 1000' do
        expect(@Character1).to have_attributes(:health => 1000)
    end
    it 'should return status attribute of Alive' do
        expect(@Character1).to have_attributes(:status => 'Alive')
    end

    it 'should have a level attributed to it' do
        expect(@Character1).to have_attributes(:level => 1)
    end

    it 'should be able to receive damage taking health from 1000 to 900' do
        expect(@Character1.receive_damage()).to eq(900)
    end

    it 'should be able to deal damage to another character' do
        @Character1.deal_damage(@Character2)
        expect(@Character2).to have_attributes(:health => 900)
    end

    it 'should be able to change status to dead if health falls to 0' do
        @Character2.health = 100
        @Character1.deal_damage(@Character2)
        expect(@Character2).to have_attributes(:status => "Dead")
    end

    it 'health should be 0 when status is dead' do
        @Character2.health = 100
        @Character1.deal_damage(@Character2)
        expect(@Character2).to have_attributes(:health => 0)
    end

    it 'should not be able to heal from damage if dead' do
        @Character2.status = "Dead"
        @Character2.heal()
        expect(@Character2.health).to eq(0)
    end
    
    it 'should be able to heal from damage if status is alive' do
        @Character1.health = 900
        @Character1.heal()
        expect(@Character1.health).to eq(1000)
    end

    it 'should have a only heal to 1000 if below level 6' do
        expect(@Character1.heal()).to eq(1000)
    end

    it 'should be able to heal up to 1500 if level 6 or above' do
        @Character1.level = 6
        @Character1.health = 1400
        expect(@Character1.heal()).to eq(1500)
    end

    it 'should not be able to deal damage to itself' do
        @Character1.deal_damage(@Character1)
        expect(@Character1.health).to eq(1000)
    end

    xit 'should reduce damage by 50% if target is 5 or more Levels above the attacker' do
        
    end
end

# describe 'Character' do
#     subject { Character.new }
#     it 'should have a class called Character' do
#         expect(subject).to be_a(Character)
#     end
# end