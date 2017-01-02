namespace :banked do
  task :log_stdout => :environment do
    Rails.logger.extend(ActiveSupport::Logger.broadcast(Logger.new(STDOUT)))
  end

  namespace :interest do
    desc "Calculate interest accruals for the given date"
    task :accrue => [:environment,:log_stdout] do
      puts "Accruing interest for date #{date}"
      DividendManager.add_missing_accruals(date)
    end

    desc "Apply weekly earnings to any account with un-applied interest accruals"
    task :apply => [:environment,:log_stdout] do
      puts "Applying interest for date #{date}"
      DividendManager.apply_earnings(date)
    end

    def date
      date_str = ENV['DATE']
      unless date_str.nil? || date_str.empty?
        Date.parse(date_str)
      else
        4.hours.ago.to_date
      end
    end
  end
end
