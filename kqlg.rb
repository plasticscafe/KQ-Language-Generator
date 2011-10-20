#!/usr/bin/env ruby
## -*- coding: utf-8 -*-
# 
# # Programming Language KQ Reverse Compiler

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



# local
def local(buffer)
  exit if buffer.empty?
  buffer.map{|elem| (r('+')*elem) + r('.')}.join(r('>'))
end

# express
def express(buffer)
  exit if buffer.empty?

  res = r('+') * buffer[0] + r('.')
  return res if buffer.size < 2
  
  buffer.each_index do |i|
    next if i == 0
    diff = buffer[i] - buffer[i-1]
    operator = (0 < diff) ? r('+') : r('-')
    res << operator * diff.abs
    res << r('.')
  end
  
  return res
end

""" just idea now implementing
# limited_express
def limited_express(buffer)
  exit if buffer.size
  
  half = buffer[0] / 2
  res = r('+') if (buffer[0] % 2).zero?
  res ||= r('>') + r('[') + ('<')
  res << r('+') * half
  res = r('>') + r(']') + r('<') + r('.')
  return res if buffer.size < 2
  
  buffer.each_index{|i|
    next if i == 0
    diff = buffer[i] - buffer[i - 1]
    operator = (0 < diff) ? r('+'): r('-')
    res << operator * diff.abs
    res << r('.')
  }
  return res

  // origin idea
  res = ''
  len = buffer.length
  exit if len < 1
  half = buffer[0] / 2
  res += r('+')  if buffer[0] % 2 #= never false this code. 'couse In ruby 0 is true.
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
  // end of origin idea
end
""" 

# TODO : より短く 
# limited express
# Green Limited Express
# wing
if __FILE__ == $0
  while line = gets
    exit if (/exit/ =~ line)
    p express(line.to_buffer)
  end
  #p local(buffer)
  #p express(buffer)
  #p limited_express(buffer)
end

