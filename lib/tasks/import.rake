require 'rmeetup'

desc "Import events from Meetup"
task :import_events_meetup => [:environment] do
  groups = Group.find_all_by_approval(true)
  meetup_groups = groups.find_all {|group| group.meetup_id? }
  
  meetup_groups.each do |group|
    # puts "Group id: #{group.id} \n"
    Group.fetch_events_from_meetup(group)
    sleep 1 #prevent getting throttled by Meetup API
  end
end

desc "Import total members for each group from Meetup"
task :import_group_members_count => [:environment] do
  groups = Group.find_all_by_approval(true)
  meetup_groups = groups.find_all {|group| group.meetup_id? }
  
  meetup_groups.each do |group|
    # puts "Group id: #{group.id} \n"
    Group.fetch_members_count_from_meetup(group)
    sleep 1 #prevent getting throttled by Meetup API
  end
end