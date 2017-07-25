class ApiConsumer < ApplicationRecord
  def self.create_from_omniauth(auth)
    create! do |consumer|
      consumer.provider = auth['provider']
      consumer.uid      = auth['uid']
      consumer.name     = auth['info']['nickname']
      consumer.email    = auth[:info][:email] ||
                          auth[:info][:emails].first[:value]
    end
  end
end
