require "gpio"
require "adc"
require "pwm"

class Robot
  def initialize(led1, led2, mot1, mot2, mot3, mot4, ref1, ref2, servo)
    @led1 = GPIO.new(led1, GPIO::OUT)
    @led2 = GPIO.new(led2, GPIO::OUT)
    @mot1 = GPIO.new(mot1, GPIO::OUT)
    @mot2 = GPIO.new(mot2, GPIO::OUT)
    @mot3 = GPIO.new(mot3, GPIO::OUT)
    @mot4 = GPIO.new(mot4, GPIO::OUT)
    @ref1 = ADC.new(ref1)
    @ref2 = ADC.new(ref2)
    @servo = PWM.new(servo, frequency:50, duty:7.25)
  end

  def leg_r_fwd
    @mot1.write 1
    @mot2.write 0
  end

  def leg_r_rwd
    @mot1.write 0
    @mot2.write 1
  end

  def leg_r_stop
    @mot1.write 0
    @mot2.write 0
  end

  def leg_l_fwd
    @mot3.write 1
    @mot4.write 0
  end

  def leg_l_rwd
    @mot3.write 0
    @mot4.write 1
  end

  def leg_l_stop
    @mot3.write 0
    @mot4.write 0
  end
  
  def forward
    leg_r_fwd
    leg_l_fwd
  end

  def turn_left
    leg_r_fwd
    leg_l_stop
  end

  def turn_right
    leg_r_stop
    leg_l_fwd
  end

  def stop
    leg_r_stop
    leg_l_stop
  end

  def rotate_right
    leg_r_rwd
    leg_l_fwd
  end

  def rotate_left
    leg_r_fwd
    leg_l_rwd
  end

  def swing
    @servo.duty(2.5)
    20000.times {}
    @servo.duty(7.25)
    20000.times {}
  end

  def led1_on
    @led1.write 1
  end

  def led1_off
    @led1.write 0
  end

  def led2_on
    @led2.write 1
  end

  def led2_off
    @led2.write 0
  end

  def ref_r
    return @ref1.read
  end

  def ref_l
    return @ref2.read
  end
  
end

# Robot.new(led1, led2, mot1, mot2, mot3, mot4, ref1, ref2, servo)
r = Robot.new(1, 2, 16, 17, 18, 19, 26, 27, 0)

r.led1_on
r.led2_on

until r.ref_r < 0.3 && r.ref_l < 0.3 do
  r.forward
  sleep 0.5
  if r.ref_r < 0.3
    r.turn_right
    sleep 0.5
  end
  if r.ref_l < 0.3
    r.turn_left
    sleep 0.5
  end
end
 
r.led1_off
r.led2_off

r.forward
sleep 2
r.swing

r.led1_on

until r.ref_r > 3 && r.ref_l > 3 do
  r.forward
  sleep 0.5
end

r.led1_off
  
r.rotate_right
sleep 3

r.led2_on
  
until r.ref_r > 3 && r.ref_l > 3 do
  r.forward
  sleep 0.5
end

r.led2_off
  
while true do
  r.forward
  r.led1_on
  r.led2_on
  sleep 0.5
  r.led1_off
  r.led2_off
  if r.ref_r < 0.3
    r.turn_right
    sleep 0.5
  end
  if r.ref_l < 0.3
    r.turn_left
    sleep 0.5
  end
end
