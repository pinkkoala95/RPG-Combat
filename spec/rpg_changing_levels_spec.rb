require './rpg_combat.rb'


describe "Changing_level" do
    before (:each) do
        @Character1 = Character.new
    end

    it 'should be able to count damage points' do
        @Character1.update_damage_tally()
        expect(@Character1).to have_attributes(:damage_tally => 50)
    end
end