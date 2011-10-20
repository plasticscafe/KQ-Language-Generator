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
input = STDIN.readlines.join.chomp.force_encoding('UTF-8')
buffer = []
input.each_byte{|c| buffer.push(c)}

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
#p local(buffer)
p express(buffer)
#p limited_express(buffer)


# TODO : より短く 
# limited express
# Green Limited Express
# wing
