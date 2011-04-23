namespace :rmedix do

  ROOT = File.dirname(__FILE__) + '/../../'

  desc "Installs required files"
  task :install do
    FileUtils.cp_r Dir[ROOT + '/assets/flowplayer'],       ::Rails.root.to_s + '/public'
    FileUtils.cp_r Dir[ROOT + '/assets/flexpaper'],        ::Rails.root.to_s + '/public'
    FileUtils.cp   Dir[ROOT + '/assets/javascripts/*.js'], ::Rails.root.to_s + '/public/javascripts'
    FileUtils.cp   Dir[ROOT + '/assets/css/*.css'],        ::Rails.root.to_s + '/public/stylesheets'
  end

  desc "Uninstalls files"
  task :remove do
    FileUtils.rm_rf ::Rails.root.to_s + '/public/flowplayer'
    FileUtils.rm_rf ::Rails.root.to_s + '/public/flexpaper'
    FileUtils.rm_f %w{swfobject.js flexpaper_flash.js flowplayer-3.2.4.min.js flowplayer.playlist-3.0.8.min.js}.collect { |file| ::Rails.root.to_s + "/public/javascripts/" + file  }
  end
end
