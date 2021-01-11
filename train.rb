# frozen_string_literal: true

require_relative('./info')
require_relative('./instance_counter')
require_relative('./validate')

class Train
  include Info
  include InstanceCounter
  include Validate

  attr_accessor :number, :type, :route, :speed, :carriages

  NUM_FORMAT = /^[a-zа-яA-ZА-Я\d]{3}-?[a-zа-яA-ZА-Я\d]{2}$/i.freeze
  NUM_ERROR = 'Неверный формат номера'

  @@trains = {}

  def initialize(number, speed = 0)
    @number = number
    @type = type
    @speed = speed
    @carriages = []
    @@trains[number] = self
    validate!
  end

  def self.find(number)
    @@trains[number]
  end

  def add_carriage(carriage)
    @carriages << carriage if speed.zero?
  end

  def remove_carriage(carriage)
    puts 'Нельзя отцеплять вагоны когда поезд в пути!' if speed != 0
    @carriages.delete(carriage) if @carriages.include?(carriage)
  end

  def stop
    @speed = 0
  end

  def go(speed)
    @speed += speed
  end

  def current_speed
    @speed
  end

  def each_carriage(&block)
    @carriages.each(&block)
  end

  def show_carriage
    @carriages.each { |carriage| puts carriage }
  end

  def add_route(route)
    @station = route.stations.first
    @station.get_train(self)
    @route = route
  end

  def next_station
    route.stations[route.stations.index(station) + 1] if @station != route.stations.last
  end

  def prev_station
    route.stations[route.stations.index(station) - 1] if @station != route.stations.first
  end

  def move_next
    if next_station
      @station.send_train(self)
      @station = next_station
      @station.get_train(self)
    end
  end

  def move_prev
    if prev_station
      @station.send_train(self)
      @station = prev_station
      @station.get_train(self)
    end
  end

  def self.find(number)
    @@trains[number]
    ObjectSpace.each_object(self).find { |train| train.number == number }
  end

  def validate!
    raise 'Длина номера меньше пяти символов' if number.length < 3
    raise 'Неверный формат номера' if number !~ NUM_FORMAT
  end
end
