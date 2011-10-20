#!/usr/bin/env ruby
## -*- coding: utf-8 -*-
# 
# # Programming Language KQ Reverse Compiler

# define kq
def r(mark)
    kq = {
        '>' => 'ﾀﾞｧｲｪｽ',
        '<' => 'ｲｪｽﾀﾞｧ',
        '+' => 'ﾀﾞｧﾀﾞｧ',
        '-' => 'ｼｴﾘｼｴﾘ',
        ',' => 'ﾀﾞｧｼｴﾘ',
        '.' => 'ｼｴﾘﾀﾞｧ', # print
        '[' => 'ｼｴﾘｲｪｽ',
        ']' => 'ｲｪｽｼｴﾘ',
    }
    sep = '!' * (rand(2) + 1)
    kq[mark] + sep 
end 

# get string
# String#force_encoding is added in Ruby 1.9
class String
  def to_buffer
    self.chomp.force_encoding('UTF-8').each_byte.to_a
  rescue NoMethodError
    p "Please use 1.9.x"
    exit
  end
end

# local
def local(buffer)
    res = ''
    len = buffer.length
    exit if len < 1
    0.upto(len-1) {|i|
        0.upto(buffer[i] - 1) { res += r('+') }
        res += r('.')
        res += r('>') if i < (len - 1)
    }
    return res
end

# express
def express(buffer)
    res = ''
    len = buffer.length
    exit if len < 1
    0.upto(buffer[0] - 1) { res += r('+') }
    res += r('.')
    return res if len < 2
    1.upto(len-1) {|i|
        diff = buffer[i] - buffer[i-1]
        (0 < diff) ? diff.downto(1) { res += r('+') } : diff.abs.downto(1) { res += r('-') }
        res += r('.')
    }
    return res
end


# limited_express
""" just idea now implementing
def limited_express(buffer)
    res = ''
    len = buffer.length
    exit if len < 1
    half = buffer[0] / 2
    res += r('+')  if buffer[0] % 2
    res += r('>') + r('[') + r('<')
    0.upto(half - 1) { res += r('+') }
    res += r('>') + r(']') + r('<') + r('.')
    return res if len < 2
    1.upto(len-1) {|i|
        diff = buffer[i] - buffer[i-1]
        (0 < diff) ? diff.downto(1) { res += r('+') } : diff.abs.downto(0) { res += r('-') }
        res += r('.')
    }
    return res
    
end
""" 

# TODO : より短く 
# limited express
# Green Limited Express
# wing
if __FILE__ == $0
  while line = gets
    exit if (/exit/ =~ line)
    p local(line.to_buffer)
  end
  #p local(buffer)
  #p express(buffer)
  #p limited_express(buffer)
end

