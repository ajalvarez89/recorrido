# frozen_string_literal: true

Engineer.destroy_all
Service.destroy_all
Contract.destroy_all

engineers = Engineer.create!([
  { name: 'Alvaro' },
  { name: 'John' },
  { name: 'Elon' }
])

services = Service.create!([
  { name: 'Recorrido.cl', description: 'Monitoring service for Recorrido.cl' },
  { name: 'Monsters Inc.', description: 'Monitoring service for Monsters Inc.' }
])

contract_one = Contract.create!(
  start_date: '2024-08-19',
  end_date: '2024-08-25',
  start_hour_weekday: 15,
  end_hour_weekday: 20,
  start_hour_weekend: 10,
  end_hour_weekend: 12,
  service_id: services.first.id
)
contract_two = Contract.create!(
  start_date: '2024-08-19',
  end_date: '2024-08-25',
  start_hour_weekday: 10,
  end_hour_weekday: 12,
  start_hour_weekend: 19,
  end_hour_weekend: 21,
  service_id: services.last.id
)

ContractCreatedEvent.new(contract_one).publish!
ContractCreatedEvent.new(contract_two).publish!

