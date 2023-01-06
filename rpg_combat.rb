class Character
    attr_accessor :health,:status, :level, :faction

    def initialize(health: 1000, status: "Alive", level: 1, faction: [])
        @health = health
        @status = status
        @level = level
        @faction = faction
    end

    def deal_damage(character)
        if character == self
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

    def join_faction()
        @faction.append("faction1")
    end

    def leave_faction()
        @faction.delete("faction1")
    end
end
#Characters may belong to one or more Factions.
# A Character may Join or Leave one or more Factions.