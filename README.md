# kani-robo-r2p2

  
## sample

### temperature

```ruby
require 'adc'

def cal_temp(val)
  27 - (val * 3.3 / (1<<12) - 0.706) / 0.001721
end

adc = ADC.new(:temperature)

while true
  puts cal_temp(adc.read)
  sleep 1
end
```

### photo reflector

* 白のときの値 0.22 前後
* 黒のときの値 3.3 前後

```ruby
require 'adc'

adc = ADC.new(26)

while true
  puts adc.read
  sleep 1
end
```

### LED

```ruby
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
```