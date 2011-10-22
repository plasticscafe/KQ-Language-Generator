## -*- coding: utf-8 -*-
# 
# # Programming Language KQ Reverse Compiler

class Kqlg
  def _add(mark)
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
    kq[mark] + '!' * (rand(2) + 1)
  end 

  def initialize(input)
    @buffer = input.chomp.force_encoding('UTF-8').unpack("C*")
  end

  # --
  # under in these action methods, return nil when error occurred
  # --

  # local
  def local()
    return nil if @buffer.empty?
    @buffer.map{|elem| (_add('+')*elem) + _add('.')}.join(_add('>'))
  end

  # express
  def express()
    return nil if @buffer.empty?

    res = _add('+') * @buffer[0] + _add('.')
    return res if @buffer.size < 2
  
    @buffer.each_index do |i|
      next if i == 0
      diff = @buffer[i] - @buffer[i-1]
      operator = (0 < diff) ? _add('+') : _add('-')
      res << operator * diff.abs
      res << _add('.')
    end
    res
  end

  # limited_express
  """
  def limited_express()
    return nil if @buffer.empty?
  
    half = @buffer[0] / 2
    res = _add('+') if (@buffer[0] % 2).zero?
    res ||= _add('>') + _add('[') + ('<')
    res << _add('+') * half
    res += _add('>') + _add(']') + _add('<') + _add('.')
    return res if @buffer.size < 2
  
    @buffer.each_index{|i|
      next if i == 0
      diff = @buffer[i] - @buffer[i - 1]
      operator = (0 < diff) ? _add('+'): _add('-')
      res << operator * diff.abs
      res << _add('.')
    }
    return res
  end
  """

  # when called unimplemented method, 
  # this method work to return nil.
  def method_missing(method, *args)
    nil
  end

  # TODO : more short 
  # Green Limited Express
  # wing
end
