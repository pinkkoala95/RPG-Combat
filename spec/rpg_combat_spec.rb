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
end

# describe 'Character' do
#     subject { Character.new }
#     it 'should have a class called Character' do
#         expect(subject).to be_a(Character)
#     end
# end

