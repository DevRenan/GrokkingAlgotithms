# frozen_string_literal: true


states_needed = Set["mt", "wa", "or", "id", "nv", "ut","ca", "az"]

stations = {}
stations["kone"] = Set["id", "nv", "ut"]
stations["ktwo"] = Set["wa", "id", "mt"]
stations["kthree"] = Set["or", "nv", "ca"]
stations["kfour"] = Set["nv", "ut"]
stations["kfive"] = Set["ca", "az"]
final_stations = Set[]

while states_needed.any?
  best_station = nil
  states_covered = Set[]
  stations.each do |station, states|
    covered = states_needed & states
    if covered.size > states_covered.size
      best_station = station
      states_covered = covered
    end
  end
  states_needed -= states_covered
  final_stations.add(best_station)
end

puts final_stations