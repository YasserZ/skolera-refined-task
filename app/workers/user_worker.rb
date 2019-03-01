class UserWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  require 'csv'
  require 'date'

  def perform
    @users = User.all
    path = Rails.root.join('storage',  'users.csv')
    File.open(path, 'w') { |file| file.write(@users.to_csv) }
  end
end
