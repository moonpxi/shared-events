class Event
  include MongoMapper::Document

  key :title, String
  key :description, String
  key :start_at, Time
  key :end_at, Time

  key :participant_ids, Array
  many :participants, :class_name => 'User', :in => :participant_ids

  def self.find_within_period_for(user, period)
    within_period = {'$gte' => period[:from].to_time} 
    within_period.merge!('$lte' => period[:to].to_time + 169999) if period[:to]

    Event.where(:participant_ids => user.id, :start_at => within_period)
  end

end
