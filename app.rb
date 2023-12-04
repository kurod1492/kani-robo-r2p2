require "gpio"
require "adc"

class LED
  def intialize(pin)
    @gpio = GPIO.new(pin, GPIO::OUT)
  end 

  def blink
    @gpio.write 1
    sleep 1
    @gpio.write 0
    sleep 1
  end
end

class Robot
  def intialize(mot1, mot2, mot3, mot4, ref_r, ref_l)
    @mot1 = GPIO.new(mot1, GPIO::OUT)
    @mot2 = GPIO.new(mot2, GPIO::OUT)
    @mot3 = GPIO.new(mot3, GPIO::OUT)
    @mot4 = GPIO.new(mot4, GPIO::OUT)
    @ref_r = ADC.new(ref_r)
    @ref_l = ADC.new(ref_l)
  end

  # motor driver "drv8833"
  # IN1 IN2 モーターにかかる力
  # LOW LOW 無
  # HIGH LOW 正転
  # LOW HIGH 逆転
  # HIGH HIGH ブレーキ

  def forward
    @mot1.write 1
    @mot2.write 0
    @mot3.write 1
    @mot4.write 0
  end

  def back
    @mot1.write 0
    @mot2.write 1
    @mot3.write 0
    @mot4.write 1
  end

  def turn_right
    @mot1.write 0
    @mot2.write 0
    @mot3.write 1
    @mot4.write 0
  end

  def turn_left
    @mot1.write 1
    @mot2.write 0
    @mot3.write 0
    @mot4.write 0
  end

  def stop
    @mot1.write 0
    @mot2.write 0
    @mot3.write 0
    @mot4.write 0
  end

end

# boot check
led = LED.new(25)
l = LED.new(25)
l.blink
l.blink
l.blink


# Right Leg system
# mot1: GP16-IN1-OUT1-Blue(+)
# mot2: GP17-IN2-OUT2-Yellow(-)
# Left Leg system
# mot3: GP18-IN3-OUT3-White(-)
# mot4: GP19-IN4-OUT4-Red(+)

# Line sensor
# ref_r: reflector right -> GP26(ADC0)
# ref_l: reflector left  -> GP27(ADC1)

r = Robot.new(16, 17, 18, 19, 26, 27)
r.forward
sleep 1
r.stop
