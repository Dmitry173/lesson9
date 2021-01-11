# frozen_string_literal: true

require_relative('./info')

class Carriage
  include Info
  attr_accessor :type, :number

  def initialize(number, type, place)
    @number = number
    @type = type
    @place = place
    @occupied_place = 0
  end

  def occupy_place(place)
    @occupied_place += place
  end

  attr_reader :occupied_place

  def free_place
    @place - @occupied_place
  end
end
