# Основной класс для управления.

require_relative 'railway_station'
require_relative 'train'
require_relative 'route'

puts '============================'
puts '1. Create railway stations'
puts '============================'

paris = RailwayStation.new :paris
berlin = RailwayStation.new :berlin
prague = RailwayStation.new :prague
moscow = RailwayStation.new :moscow

puts '================='
puts '2. Create route'
puts '================='

route = Route.new
route.add_station :paris
route.add_station :berlin
route.add_station :prague
route.add_station :moscow

puts '================='
puts '3. Create train'
puts '================='

cargo = Train.new(13, :cargo, rand(30..50))

puts '=========================='
puts '4. Hook 2 more carriages'
puts '=========================='

cargo.hook_carriage
cargo.hook_carriage

puts '=================================='
puts '5. Check the length of the train'
puts '=================================='

cargo.train_length

puts '==========================='
puts '6. Set the route to train'
puts '==========================='

cargo.route! route

puts '==================================='
puts "7. Show train's departure station"
puts '==================================='

cargo.train_departure_station

puts '===================================='
puts "8. Set train's destination station"
puts '===================================='

cargo.train_destination_station

puts '======================================================'
puts '9. Train starting to move from departure station (1)'
puts '======================================================'

paris.allow_departure!(cargo)

puts '===================================='
puts "10. Train checks the current speed"
puts '===================================='

cargo.current_speed

puts '============================'
puts "11. Train raises the speed"
puts '============================'

cargo.speed_up
cargo.speed_up

puts '============================='
puts "12. Train loweres the speed"
puts '============================='

cargo.speed_down

puts '============================================='
puts '13. Move train to the next station in route'
puts '============================================='

cargo.move!

puts '==============================================='
puts '14. Train arrives to the station (2) in route'
puts '==============================================='

berlin.allow_arrival!(cargo)
cargo.current_speed

puts '=========================='
puts '15. Hook 1 more carriage'
puts '=========================='

cargo.hook_carriage

puts '================================='
puts '16. And unhook 2 more carriages'
puts '================================='

cargo.unhook_carriage
cargo.unhook_carriage

puts '=========================================='
puts '17. Check the trains at stations 1 and 2'
puts '=========================================='

paris.trains_at_station
berlin.trains_at_station

puts '======================================================='
puts '18. Train starting to move from departure station (2)'
puts '======================================================='

berlin.allow_departure!(cargo)

puts '============================================='
puts '19. Move train to the next station in route'
puts '============================================='

cargo.move!

puts '==============================================='
puts '20. Train arrives to the station (3) in route'
puts '==============================================='

prague.allow_arrival!(cargo)

puts '======================================================='
puts '21. Train starting to move from departure station (3)'
puts '======================================================='

prague.allow_departure!(cargo)

puts '============================================='
puts '22. Move train to the next station in route'
puts '============================================='

cargo.move!

puts '=========================================================='
puts '23. Train arrives to the destination station (4) in route'
puts '=========================================================='

moscow.allow_arrival!(cargo)

puts '======================================'
puts '24. Check the trains at all stations'
puts '======================================'

paris.trains_at_station
berlin.trains_at_station
prague.trains_at_station
moscow.trains_at_station

puts '======================================'
