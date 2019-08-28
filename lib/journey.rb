class Journey
  class JourneyInProgress < RuntimeError
  end

  class JourneyComplete < RuntimeError
  end

  attr_reader :entry_station, :exit_station

  def start(entry_station)
    @entry_station = entry_station
  end

  def stop(exit_station)
    @exit_station = exit_station
  end

  def in_progress?
    !@entry_station.nil? && @exit_station.nil?
  end
end