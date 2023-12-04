# kani-robo-r2p2

## sample

### LED
pin = GPIO.new(25, GPIO::OUT)
while true
  pin.write 1
  sleep 1
  pin.write 0
  sleep 1
end

### temperature
require 'adc'

def cal_temp(val)
  27 - (val * 3.3 / (1<<12) - 0.706) / 0.001721
end

adc = ADC.new(:temperature)

while true
  puts cal_temp(adc.read)
  sleep 1
end

### photo reflector
require 'adc'

adc = ADC.new(26)

while true
  puts adc.read
  sleep 1
end

### LED 
require "gpio"

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

led = LED.new(25)
led.blink
