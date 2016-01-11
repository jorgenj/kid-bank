module NoisyPuts
  def puts_with_line_info(msg)
    puts_without_line_info "Called from #{caller(1)[0]}"
    puts_without_line_info msg
  end

  alias_method_chain :puts, :line_info
end

RSpec.configure do |config|
  config.include NoisyPuts
end
