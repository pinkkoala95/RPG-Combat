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

    # doing the method first then checking the character attributes are what we expect 
    it 'should not be able to deal damage to itself' do
        @Character1.deal_damage(@Character1)
        expect(@Character1).to have_attributes(:health => 1000)
    end

    # checking the output of the method is equal to what we expect
    it 'should not be able to deal damage to itself' do
        expect(@Character1.deal_damage(@Character1)).to eq(1000)
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
        @Character1.status = "Dead"
        @Character1.heal()
        expect(@Character1.health).to eq(0)
    end
    
    it 'should be able to heal from damage if status is alive' do
        @Character1.health = 900
        @Character1.heal()
        expect(@Character1.health).to eq(1000)
    end

    it 'should only heal to 1000 if below level 6' do
        expect(@Character1.heal()).to eq(1000)
    end

    it 'should be able to heal up to 1500 if level 6 or above' do
        @Character1.level = 6
        @Character1.health = 1400
        expect(@Character1.heal()).to eq(1500)
    end

    it 'should not heal itself if health is at 1500 (cannot be 1600)' do
        @Character1.health = 1500
        @Character1.heal()
        expect(@Character1).to have_attributes(:health => 1500)
    end


    it 'should reduce damage by 50% if target is 5 Levels above the attacker' do
        @Character1.level = 1
        @Character2.level = 6
        @Character1.deal_damage(@Character2)
        expect(@Character2).to have_attributes(:health => 950)
    end

    it 'should reduce damage by 100 if target is 4 levels above the attacker' do
        @Character1.level = 1
        @Character2.level = 5
        @Character1.deal_damage(@Character2)
        expect(@Character2).to have_attributes(:health => 900)
    end

    it 'should reduce damage by 50% if target is 5 or more Levels above the attacker' do
        @Character1.level = 1
        @Character2.level = 7
        @Character1.deal_damage(@Character2)
        expect(@Character2).to have_attributes(:health => 950)
    end

    it 'should increase damage by 50% if target is 5 Levels below the attacker' do
        @Character1.level = 6
        @Character2.level = 1
        @Character1.deal_damage(@Character2)
        expect(@Character2).to have_attributes(:health => 850)
    end

    it 'should increase damage by 50% if target is 5 or more Levels below the attacker' do
        @Character1.level = 7
        @Character2.level = 1
        @Character1.deal_damage(@Character2)
        expect(@Character2).to have_attributes(:health => 850)
    end
    it 'should reduce damage by 100 if target is 4 levels below the attacker' do
        @Character1.level = 5
        @Character2.level = 1
        @Character1.deal_damage(@Character2)
        expect(@Character2).to have_attributes(:health => 900)
    end

    it 'should initialise a character that has a faction attribute but no faction is allocated to it' do
        expect(@Character1).to have_attributes(:faction => [])
    end

    it 'should join a character to a faction' do
        @Character1.join_faction("faction1")
        expect(@Character1).to have_attributes(:faction => ["faction1"])
    end

    it 'should leave a character to a faction' do
        @Character1.faction = ["faction1"]
        @Character1.leave_faction("faction1")
        expect(@Character1).to have_attributes(:faction => [])
    end

    it 'should be able to join a character to multiple factions' do
        @Character1.join_faction("faction1", "faction2")
        expect(@Character1).to have_attributes(:faction => ["faction1", "faction2"])
    end

    it 'should be able to use the join method to join no factions and still have an empty array' do
        @Character1.join_faction()
        expect(@Character1).to have_attributes(:faction => [])
    end

    it 'should be able to leave a character from mutliple factions' do
        @Character1.faction = ["faction1", "faction2", "faction3"]
        @Character1.leave_faction("faction1","faction2", "faction3")
        expect(@Character1).to have_attributes(:faction => [])
    end

    it 'should be able to leave a character from mutliple factions and stay in one faction' do
        @Character1.faction = ["faction1", "faction2", "faction3"]
        @Character1.leave_faction("faction2")
        expect(@Character1).to have_attributes(:faction => ["faction1", "faction3"])
    end

    it 'should not be able to deal damage if characters are allies (same faction)'do
        @Character1.faction = ["faction1"]
        @Character2.faction = ["faction1"]
        @Character1.deal_damage(@Character2)
        expect(@Character2).to have_attributes(:health => 1000)
    end

    it 'should check if character belongs to the same faction as ourself' do
        @Character1.faction = ["faction1"]
        @Character2.faction = ["faction1"]
        expect( @Character1.allie_check(@Character2)).to eq("allies")
    end

    it 'should check if character belongs to different faction to ourself' do
        @Character1.faction = ["faction1"]
        @Character2.faction = ["faction2"]
        expect( @Character1.allie_check(@Character2)).to eq("non-allies")
    end

    it 'should check if character belongs to at least one of the same factions to ourself' do
        @Character1.faction = ["faction1"]
        @Character2.faction = ["faction1","faction2"]
        expect( @Character1.allie_check(@Character2)).to eq("allies")
    end

    it 'should check if character belongs to at least one of the same factions to ourself' do
        @Character1.faction = ["faction1","faction2"]
        @Character2.faction = ["faction1"]
        expect( @Character1.allie_check(@Character2)).to eq("allies")
    end

    it 'should check if character belongs to at least one of the same factions to ourself' do
        @Character1.faction = ["faction1","faction2"]
        @Character2.faction = ["faction3","faction4"]
        expect( @Character1.allie_check(@Character2)).to eq("non-allies")
    end

    it 'should not be able to deal damage if characters are allies (same faction)'do
        @Character1.faction = ["faction1","faction2"]
        @Character2.faction = ["faction1"]
        @Character1.deal_damage(@Character2)
        expect(@Character2).to have_attributes(:health => 1000)
    end

    it 'should be able to deal damage if characters are non-allies'do
        @Character1.faction = ["faction1","faction2"]
        @Character2.faction = ["faction3","faction4"]
        @Character1.deal_damage(@Character2)
        expect(@Character2).to have_attributes(:health => 900)
    end

    it 'should be able to heal if is an allie' do
        @Character1.health = 800
        @Character1.faction = ["faction1"]
        @Character2.faction = ["faction1"]
        @Character2.heal_another(@Character1)
        expect(@Character1).to have_attributes(:health => 900)
    end

    it 'should not be able to heal if is not an allie' do
        @Character1.health = 800
        @Character1.faction = ["faction1"]
        @Character2.faction = ["faction2"]
        @Character2.heal_another(@Character1)
        expect(@Character1).to have_attributes(:health => 800)
    end


end

# describe 'Character' do
#     subject { Character.new }
#     it 'should have a class called Character' do
#         expect(subject).to be_a(Character)
#     end
# end