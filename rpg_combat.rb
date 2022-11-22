class Character
    attr_accessor :health,:status

    def initialize(health: 1000, status: "Alive")
        @health = health
        @status = status
    end
end

