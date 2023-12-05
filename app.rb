require "gpio"
require "adc"

LEDPIN = 25

# Right Leg system
# mot1: GP16-IN1-OUT1-Blue(+)
# mot2: GP17-IN2-OUT2-Yellow(-)
# Left Leg system
# mot3: GP18-IN3-OUT3-White(-)
# mot4: GP19-IN4-OUT4-Red(+)

MOT1 = 16
MOT2 = 17
MOT3 = 18
MOT4 = 19

# Line sensor
# ref_r: reflector right -> GP26(ADC0)
# ref_l: reflector left  -> GP27(ADC1)

REFR = 26
REFL = 27

def blink
  led = GPIO.new(LEDPIN, GPIO::OUT)
  led.write 1
  sleep 0.2
  led.write 0
end
blink

while true

  # motor driver "drv8833"
  # IN1 IN2 モーターにかかる力
  # LOW LOW 無
  # HIGH LOW 正転
  # LOW HIGH 逆転
  # HIGH HIGH ブレーキ

  def forward
    mot1 = GPIO.new(MOT1, GPIO::OUT)
    mot2 = GPIO.new(MOT2, GPIO::OUT)
    mot3 = GPIO.new(MOT3, GPIO::OUT)
    mot4 = GPIO.new(MOT4, GPIO::OUT)
    
    mot1.write 1
    mot2.write 0
    mot3.write 1
    mot4.write 0
  end

  def back
    mot1 = GPIO.new(MOT1, GPIO::OUT)
    mot2 = GPIO.new(MOT2, GPIO::OUT)
    mot3 = GPIO.new(MOT3, GPIO::OUT)
    mot4 = GPIO.new(MOT4, GPIO::OUT)
    
    mot1.write 0
    mot2.write 1
    mot3.write 0
    mot4.write 1
  end

  def turn_right
    mot1 = GPIO.new(MOT1, GPIO::OUT)
    mot2 = GPIO.new(MOT2, GPIO::OUT)
    mot3 = GPIO.new(MOT3, GPIO::OUT)
    mot4 = GPIO.new(MOT4, GPIO::OUT)
    
    mot1.write 0
    mot2.write 0
    mot3.write 1
    mot4.write 0
  end

  def turn_left
    mot1 = GPIO.new(MOT1, GPIO::OUT)
    mot2 = GPIO.new(MOT2, GPIO::OUT)
    mot3 = GPIO.new(MOT3, GPIO::OUT)
    mot4 = GPIO.new(MOT4, GPIO::OUT)
    
    mot1.write 1
    mot2.write 0
    mot3.write 0
    mot4.write 0
  end
  
  def stop
    mot1 = GPIO.new(MOT1, GPIO::OUT)
    mot2 = GPIO.new(MOT2, GPIO::OUT)
    mot3 = GPIO.new(MOT3, GPIO::OUT)
    mot4 = GPIO.new(MOT4, GPIO::OUT)
    
    mot1.write 0
    mot2.write 0
    mot3.write 0
    mot4.write 0
  end
  
  def ref_r
    ADC.new(REFR).read
  end
  
  def ref_l
    ADC.new(REFL).read
  end
  
  # white ref_r = 0.22
  # black ref_r = 3.3
    
  if  ref_l < 1 && ref_r < 1
    stop
    sleep 0.1
  elsif ref_l < 1 && ref_r > 1
    turn_left
    sleep 0.1
  elsif ref_l > 1 && ref_r < 1
    turn_right
    sleep 0.1
  else
    forward
    sleep 0.1
  end
end
