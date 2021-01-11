# frozen_string_literal: true

class CargoTrain < Train
  def initialize(number)
    super
    @type = :cargo
  end

  def add_carriage(carriage)
    carriage.is_a?(CargoCarriage)
  end
end
