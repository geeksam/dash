require 'factory_girl'

Factory.define :team, :class => Team do |team|
  team.name 'Dust Bunnies'
end

Factory.sequence(:sprint_number) { |n| n }

Factory.define :sprint, :class => Sprint do |sprint|
  sprint.team { |a| a.association(:team) }
  sprint.number Factory.next(:sprint_number)
  sprint.starts_on 1.day.ago
  sprint.ends_on 1.day.from_now
end

Factory.sequence(:iteration_number) { |n| n }

Factory.define :iteration, :class => Iteration do |iteration|
  iteration.sprint { |a| a.association(:sprint) }
  iteration.number Factory.next(:iteration_number)
end
