require "pwm"
require "task"

class Robot
  def initialize(pin)
    @pwm = PWM.new(pin,frequency:50, duty:7.25)
  end

  def duty(d)
    @pwm.duty(d)
  end

end

r = Robot.new(0)

Task.new(r) do
  r.duty(2.5)
  sleep 2
  r.duty(12)
  sleep 2
  r.duty(7.25)
end


