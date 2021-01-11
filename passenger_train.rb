# frozen_string_literal: true

class PassengerTrain < Train
  def initialize(number)
    super
    @type = :passenger
  end

  def add_carriage(carriage)
    carriage.is_a?(PassCarriage)
  end
end
