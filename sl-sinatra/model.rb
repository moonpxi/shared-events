require_relative 'model/user'
require_relative 'model/event'

EVENTS = []

def rand_today
  DateTime.now + rand - 0.5
end

def bootstrap_model
  User.remove
  Event.remove

  unless User.find_by_name('Paulo')
    users = %w{Paulo Cris}.map { |name| User.create(:name => name) }


    Event.create(:title => 'Something tomorrow',
                 :start_at => rand_today + 1,
                 :participants => [users.first, users.last])

    Event.create(:title => 'Something yesterday',
                 :start_at => rand_today - 1,
                 :participants => [users.first])

    Event.create(:title => 'Something today',
                 :description => 'Today is today is today',
                 :start_at => rand_today,
                 :participants => [users.first])

    Event.create(:title => 'Something next week',
                 :start_at => rand_today + 7,
                 :participants => [users.first])


    Event.create(:title => 'Something with start and end',
                 :start_at => DateTime.now,
                 :end_at => DateTime.now + 0.2,
                 :participants => [users.first])

   end
end
