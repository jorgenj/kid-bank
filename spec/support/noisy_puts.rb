module NoisyPuts
  def puts(msg)
    super "Called from #{caller(1)[0]}"
    super msg
  end
end

RSpec.configure do |config|
  config.include NoisyPuts
end
