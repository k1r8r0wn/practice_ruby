require_relative 'train'

class RailwayStation
  include Company
  include InstanceCounter

  attr_reader :name_station, :train_list
  INITIAL_TRAIN_SPEED = 50

  def self.information=(information)
    @@information = information
  end

  def self.all
    @@information.station.keys
  end

  def initialize(name)
    @@information ||= nil
    @registry = @@information
    @name_station = name
    @registry.station[@name_station] = self
    @train_list = []
    valid!
  end

  def all
    train_list
  end

  def each_train(&block)
    train_list.each do |x|
      block.call(x)
    end
  end

  def train_names
    names = train_list.map(&:number)
    names.join(', ')
  end

  def trains_calc
    cargo = 0
    passenger = 0
    train_list.each do |train|
      cargo += 1 if train.type == :cargo
      passenger += 1 if train.type == :passenger
    end
    { cargo: cargo, passenger: passenger }
  end

  def allow_departure!(train)
    train.on_station = false
    train.go(INITIAL_TRAIN_SPEED)
    train_list.delete(train)
  end

  def allow_arrival!(train)
    train.on_station = true
    train_list.push(train)
  end

  def valid?
    valid!
  rescue StandardError
    false
  end

  private

  attr_reader :information
  attr_writer :train_list

  def valid!
    valid_information!
    valid_name_station!
    valid_train_class!
    true
  end

  def valid_information!
    fail 'Information class is nil!' if @@information.nil?
    fail 'Not valid information object!' unless @@information.class == DataCenter
  end

  def valid_name_station!
    fail 'Station name is nil!' if name_station.nil?
    fail 'Station name is not a symbol!' if name_station.class != Symbol
    fail 'Station name is too long!' if name_station.length > 100
  end

  def valid_train_class!
    fail 'Some error with train list!' if valid_train_class?
  end

  def valid_train_class?
    train_list.any? { |train| train.class != Train }
  end
end
