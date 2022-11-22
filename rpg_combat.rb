class Character
    attr_accessor :health,:status, :level

    def initialize(health: 1000, status: "Alive", level: 1)
        @health = health
        @status = status
        @level = level
    end

    def deal_damage(character)
        character.receive_damage()
    end

    def receive_damage()
        if @health <= 100
            @health = 0
            @status = "Dead"
        else
            @health -= 100
        end
    end

    def heal(character)
        if character.status == "Dead"
            @health = 0
        elsif character.level < 6 && character.health<1000
            @health +=100
        elsif character.level >= 6 && character.health<1500
            @health += 100
        else #health is full
            @health = @health
        end
    end
end

