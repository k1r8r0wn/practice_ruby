class Information < Hash
  def initialize
    self[:train] = Array.new
    self[:station] = Array.new
  end

  def trains
    message = self.[](:train).map do |train|
      train.number
    end
    message.join(", ")
  end

  def trains_available_to_hook_and_unhook_carriages
    message = self.[](:train).each.find_all do |train|
      train.on_station == true && train.speed == 0
    end
    message.map! {|train| train.number}
    !message.empty? ? message.join(", ") : 'No trains are ready now!'
  end

  def trains_available_to_allow
    message = self.[](:train).each.find_all do |train|
      train.on_station == false
    end
    message.map! {|train| train.number}
    !message.empty? ? message.join(", ") : 'No trains are ready now!'
  end

  def trains_expanded
    message = self.[](:train).map do |train|
      train.all_trains
    end
    message.join("\n")
  end

  def stations
    message = self.[](:station).map do |station|
      station.name.capitalize
    end
    message.join("\n")
  end

  def stations_expanded
    message = self.[](:station).map do |station|
      station.trains_at_station
    end
    message.join("\n")
  end
end
