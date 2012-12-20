class Event
  include MongoMapper::Document

  key :title, String
  key :description, String
  key :start_at, Time
  key :end_at, Time

  key :participant_ids, Array
  many :participants, :class_name => 'User', :in => :participant_ids

  def self.within_period_for(user, period)
    Event.where(:participant_ids => user.id, 
                :start_at => {'$gte' => period[:from].to_time, 
                              '$lte' => period[:to].to_time + 169999})
  end

end
