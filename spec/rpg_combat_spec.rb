require './rpg_combat.rb'

describe Character do
    before (:each) do
        @Character1 = Character.new
        @Character2 = Character.new
    end

    describe 'newly created character' do
        subject(:newly_created_character) { Character.new }

        it 'has 1000 health' do
            expect(newly_created_character).to have_attributes(:health => 1000)
        end

        it 'has status "Alive"' do
            expect(newly_created_character).to have_attributes(:status => 'Alive')
        end

        it 'is level 1' do
            expect(newly_created_character).to have_attributes(:level => 1)
        end

        it 'no faction' do
            expect(newly_created_character).to have_attributes(:faction => [])
        end
    end

    describe 'damage' do
        subject(:newly_created_character) { Character.new }
        subject(:character_being_attacked) {Character.new }

        it 'receive damage' do
            expect(newly_created_character.receive_damage()).to eq(900)
        end

        it 'deal damage' do
            newly_created_character.deal_damage(character_being_attacked)
            expect(character_being_attacked).to have_attributes(:health => 900)
        end

        it 'does not deal damage to itself' do
            newly_created_character.deal_damage(newly_created_character)
            expect(newly_created_character).to have_attributes(:health => 1000)
        end
    end

    describe 'status' do

        it 'change status to dead if health falls to 0' do
            @Character2.health = 100
            @Character1.deal_damage(@Character2)
            expect(@Character2).to have_attributes(:status => "Dead")
        end

        it 'health is 0 if status is dead' do
            @Character2.health = 100
            @Character1.deal_damage(@Character2)
            expect(@Character2).to have_attributes(:health => 0)
        end

        it 'if dead then stays dead' do
            @Character1.status = "Dead"
            @Character1.heal()
            expect(@Character1.health).to eq(0)
        end
    end

    describe 'heal' do
    
        it 'if alive can heal' do
            @Character1.health = 900
            @Character1.heal()
            expect(@Character1.health).to eq(1000)
        end

        it 'heals to 1000 if below level 6' do
            expect(@Character1.heal()).to eq(1000)
        end

        it 'heals to 1500 if level 6 or above' do
            @Character1.level = 6
            @Character1.health = 1400
            expect(@Character1.heal()).to eq(1500)
        end

        it 'health will not go above 1500' do
            @Character1.health = 1500
            @Character1.heal()
            expect(@Character1).to have_attributes(:health => 1500)
        end
    end

    describe 'damage and levels' do
        it 'damage reduces by 50% if target is 5 Levels above the attacker' do
            @Character1.level = 1
            @Character2.level = 6
            @Character1.deal_damage(@Character2)
            expect(@Character2).to have_attributes(:health => 950)
        end

        it 'damage reduces by 100 if target is 4 levels above the attacker' do
            @Character1.level = 1
            @Character2.level = 5
            @Character1.deal_damage(@Character2)
            expect(@Character2).to have_attributes(:health => 900)
        end

        it 'damage reduces by 50% if target is 5 or more Levels above the attacker' do
            @Character1.level = 1
            @Character2.level = 7
            @Character1.deal_damage(@Character2)
            expect(@Character2).to have_attributes(:health => 950)
        end

        it 'damage increases by 50% if target is 5 Levels below the attacker' do
            @Character1.level = 6
            @Character2.level = 1
            @Character1.deal_damage(@Character2)
            expect(@Character2).to have_attributes(:health => 850)
        end

        it 'damage increases by 50% if target is 5 or more Levels below the attacker' do
            @Character1.level = 7
            @Character2.level = 1
            @Character1.deal_damage(@Character2)
            expect(@Character2).to have_attributes(:health => 850)
        end

        it 'damage reduces by 100 if target is 4 levels below the attacker' do
            @Character1.level = 5
            @Character2.level = 1
            @Character1.deal_damage(@Character2)
            expect(@Character2).to have_attributes(:health => 900)
        end
    end
    describe 'factions' do

        it 'can join a faction' do
            @Character1.join_faction("faction1")
            expect(@Character1).to have_attributes(:faction => ["faction1"])
        end

        it 'can leave a faction' do
            @Character1.faction = ["faction1"]
            @Character1.leave_faction("faction1")
            expect(@Character1).to have_attributes(:faction => [])
        end

        it 'can join multiple factions' do
            @Character1.join_faction("faction1", "faction2")
            expect(@Character1).to have_attributes(:faction => ["faction1", "faction2"])
        end

        it 'should be able to use the join method to join no factions and still have an empty array' do
            @Character1.join_faction()
            expect(@Character1).to have_attributes(:faction => [])
        end

        it 'can leave multiple factions' do
            @Character1.faction = ["faction1", "faction2", "faction3"]
            @Character1.leave_faction("faction1","faction2", "faction3")
            expect(@Character1).to have_attributes(:faction => [])
        end

        it 'can leave mutliple factions and stay in one faction' do
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


end
