require "pwm"

class Robot
  def initialize(pin)
    @pwm = PWM.new(pin,frequency:50, duty:7.25)
  end

  def duty(d)
    @pwm.duty(d)
  end

end

r = Robot.new(0)

r.duty(2.5)
20000.times {}
r.duty(7.25)
20000.times {}
r.duty(12)
20000.times {}
r.duty(7.25)



