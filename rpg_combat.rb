class Character
    attr_accessor :health,:status, :level

    def initialize(health: 1000, status: "Alive", level: 1)
        @health = health
        @status = status
        @level = level
    end

    def deal_damage(character)
        if character == self
            @health = @health
        elsif self.level == character.level-5
            character.receive_damage_from_lower_level()
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
end

#When dealing damage:
# If the target is 5 or more Levels above the attacker, Damage is reduced by 50%
# If the target is 5 or more Levels below the attacker, Damage is increased by 50%