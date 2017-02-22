require "timezone"
require "dotenv"
require_relative "dms_coordinate"

Dotenv.load

Timezone::Lookup.config(:google) do |c|
  c.api_key = ENV["API_KEY"]
end

class Airport
  attr_reader :latitude_dd, :longitude_dd

  def initialize(airport_pikelet_struct)
    @airport_pikelet_struct = airport_pikelet_struct
    @latitude_dd = DmsCoordinate.new_from_s(latitude).to_dd
    @longitude_dd = DmsCoordinate.new_from_s(longitude).to_dd
  end

  %w(identifier airport_name city country icao elevation latitude longitude)
  .each do |deferred_method|
    define_method(deferred_method) do
      @airport_pikelet_struct.send(deferred_method)
    end
  end

  def timezone
  end
end
