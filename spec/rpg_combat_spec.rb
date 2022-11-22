require './rpg_combat.rb'


describe Character do
    Character1 = Character.new
    it 'should have a class called Character' do
        expect(Character1).to be_a(Character)
    end
    it 'should return health attribute' do
        expect(Character1).to have_attributes(:health => 1000)
    end
    it 'should return status attribute' do
        expect(Character1).to have_attributes(:status => 'Alive')
    end

    it 'should be able to receive damage' do
        expect(Character1.receive_damage()).to eq(900)
    end

    Character2 = Character.new()
    it 'should be able to deal damage to another character' do
        Character1.deal_damage(Character2)
        expect(Character2).to have_attributes(:health => 900)
    end

    it 'should be able to change status to dead' do
        Character2.health = 100
        Character1.deal_damage(Character2)
        expect(Character2).to have_attributes(:status => "Dead")
    end

    # it 'should be able to deduct damage from another character' do
    #     expect(Character1.accept_damage()).to eq(100)
    # end

end

# describe 'Character' do
#     subject { Character.new }
#     it 'should have a class called Character' do
#         expect(subject).to be_a(Character)
#     end
# end
