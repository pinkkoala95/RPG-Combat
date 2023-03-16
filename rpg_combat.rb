class Character
    attr_accessor :health,:status, :level, :faction, :max_health, :damage_tally, :cumulative_previous_level_total
   
    def initialize(health: 1000, status: "Alive", level: 1, faction: [], max_health: 1000, damage_tally: 0, cumulative_previous_level_total: 1)
        @health = health
        @status = status
        @level = level
        @faction = faction
        @max_health = max_health
        @damage_tally = damage_tally
        @cumulative_previous_level_total = cumulative_previous_level_total
    end

    def update_level(character)
        damage_tally_needed_to_move_up_a_level = @cumulative_previous_level_total * 1000
        if @damage_tally >= damage_tally_needed_to_move_up_a_level && @health != 0
            @level += 1
            @cumulative_previous_level_total += @level
        end
    end

    def deal_damage(character)
        if character == self || self.allie_check(character) == "allies"
            @health = @health
        elsif self.level <= character.level-5
            character.receive_damage_from_lower_level()
        elsif self.level >= character.level+5
            character.receive_damage_from_higher_level()
        else
            character.receive_damage()
        end
    end

    def receive_damage()
        if @health <= 100
            @health = 0
            @status = "Dead"
        else
            @health -= 100
            @damage_tally += 100
        end
    end

    def receive_damage_from_lower_level()
        if @health <= 50
            @health = 0
            @status = "Dead"
        else
            @health -= 50
            @damage_tally += 50
        end
    end

    def receive_damage_from_higher_level()
        if @health <= 150
            @health = 0
            @status = "Dead"
        else
            @health -= 150
            @damage_tally += 150
        end
    end

    def heal()
        if @status == "Dead"
            @health = 0
        elsif @level < 6 && @health<1000
            @health +=100
        elsif @level >= 6 && @health<1500
            @health += 100
        else #health is full
            @health
        end
    end

    def heal_another(character)
        if allie_check(character) == "allies"
            character.heal()
        end
    end


    def join_faction(*faction)
        (@faction << faction).flatten!
    end

    def leave_faction(*faction)
        faction.each do |x|
            @faction.delete x
        end
    end

    def update_level_based_on_faction(character)
        if self.faction.uniq.count == 3 * @level
            @level += 1
        end
    end

    #TODO Understand how to identify distinct factions 


    def allie_check(character)
        allie_count = 0
        self.faction.each do |x|
            check = character.faction.include?(x)
            if check == true
                allie_count +=1
            else
                allie_count
            end
        end
    
        if allie_count>0 && character.faction != []
            return "allies"
        else
            return "non-allies"
        end
    end
end

class Magical_object
    attr_accessor :health,:status,:max_health

    def initialize(health: 100, status: "alive", max_health: 100)
        @health = health
        @status = status
        @max_health = max_health
    end

    def damage_object()
        if @health == 0
            @status = "destroyed"
        else 
            @status = "alive"
        end
    end
end

class Healing_magical_object < Magical_object

    def magical_giving_health(character)
        potential_health = character.health + @health
        residual_health = potential_health - character.max_health
        if potential_health <= character.max_health
            character.health = character.health + @health
            @health = 0
            @status = "destroyed"
        else
            character.health = character.max_health
            @health = residual_health
        end
    end  

    def deal_damage(character)
        character.health
    end

end

class Magical_weapon < Magical_object
    attr_accessor :damage

    def initialize(damage: 50, health:100)
        @damage = damage
        @health = health
    end

    def deal_damage(character)
        character.health = character.health - @damage
        @health = @health - 1
    end


end

# Level 1 Characters that have ever been part of 3 distinct factions gain a level
# Level 2 Characters need to join an additional 3 distinct factions to gain a level, Level 3 Characters need to join an additional 3, and so on.