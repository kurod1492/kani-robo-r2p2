require "gpio"

class Robot
  def initialize(led1, led2, mot1, mot2, mot3, mot4, ref1, ref2)
    @led1 = GPIO.new(led1, GPIO::OUT)
    @led2 = GPIO.new(led2, GPIO::OUT)
    @mot1 = GPIO.new(mot1, GPIO::OUT)
    @mot2 = GPIO.new(mot2, GPIO::OUT)
    @mot3 = GPIO.new(mot3, GPIO::OUT)
    @mot4 = GPIO.new(mot4, GPIO::OUT)
  end

  def blink1
    @led1.write 1
    sleep 1
    @led1.write 0
    sleep 1
  end

  def forward
    @mot1.write 1
    @mot2.write 0
    @mot3.write 1
    @mot4.write 0
  end

  def stop
    @mot1.write 0
    @mot2.write 0
    @mot3.write 0
    @mot4.write 0
  end

end

r = Robot.new(25,25,16,17,18,19,26,27)
r.blink1
r.blink1
r.blink1
r.forward
sleep 1
r.stop
