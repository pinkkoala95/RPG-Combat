class Character
    attr_accessor :health,:status

    def initialize(health: 1000, status: "Alive")
        @health = health
        @status = status
    end

    def deal_damage(character)
        character.receive_damage()
    end

    def receive_damage()
        if @health <= 100
            @status = "Dead"
        else
            @health -= 100
        end
    end
end

