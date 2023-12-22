require "pwm"
require "machine"

class Robot
  def initialize(pin)
    @pwm = PWM.new(pin,frequency:50, duty:7.25)
  end

  def duty(d)
    @pwm.duty(d)
  end

end

r = Robot.new(0)

Machine.using_busy_wait do
  r.duty(2.5)
  sleep_ms 2000
  r.duty(12)
  sleep_ms 2000
  r.duty(7.25)
end


