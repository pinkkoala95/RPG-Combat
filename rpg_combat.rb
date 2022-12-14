class Character
    attr_accessor :health,:status, :level, :faction, :max_health

    def initialize(health: 1000, status: "Alive", level: 1, faction: [], max_health: 1000)
        @health = health
        @status = status
        @level = level
        @faction = faction
        @max_health = max_health
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
        end
    end

    def receive_damage_from_lower_level()
        if @health <= 50
            @health = 0
            @status = "Dead"
        else
            @health -= 50
        end
    end

    def receive_damage_from_higher_level()
        if @health <= 150
            @health = 0
            @status = "Dead"
        else
            @health -= 150
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
        if potential_health <= character.max_health
            character.health = character.health + @health
        else
            character.max_health
        end
    end  
end

# Characters can gain health from a Healing Magical Object.
#   Characters can gain any amount of health 
#   from the Object, up to its maximum and theirs
#   Healing Magical Objects cannot deal Damage

#check adding max_health to character class is a good idea for 
#dealing with magical_giving_health method