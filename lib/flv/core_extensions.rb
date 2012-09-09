# Copyright (c) 2005 Norman Timmler (inlet media e.K., Hamburg, Germany)
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. The name of the author may not be used to endorse or promote products
#    derived from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


class Time
  #TODO: Figure out why we need to monkey-patch the Time class at all...
  alias :to_str :to_s
  def to_s
    # Looks like: Wed Apr 11 22:36:29 GMT-0400 2012
    strftime("%a %b %d %H:%M:%S GMT%z %Y")
  end
  def to_iso
    # Looks like: 2012-04-11T22:30:24-04:00
    strftime("%Y-%m-%dT%H:%M:%S%:z")
  end
end

class Float
  #TODO: Name this patch method something else
  alias :to_str :to_s
  def to_s
    # Don't include the decimal point if it's a whole number
    to_i == self ? to_i.to_s : to_str
  end
end

class IO
  # Patching methods to help us read byte directly from the file
  def read__UI8(position = nil)
    seek position unless position.nil?
    readbyte
  end
  
  def read__UI16(position = nil)
    seek position unless position.nil?
    (readbyte << 8) + readbyte
  end
  
  def read__UI24(position = nil)
    seek position unless position.nil?
    (readbyte << 16) + (readbyte << 8) + readbyte
  end
  
  def read__UI32(position = nil)
    seek position unless position.nil?
    (readbyte << 24) + (readbyte << 16) + (readbyte << 8) + readbyte
  end
  
  def read__STRING(length, position = nil)
    seek position unless position.nil?
    string = read length
    string.to_s
  end
  
  
  def write__UI8(value, position = nil)
    seek position unless position.nil?
    write [value].pack('C')
  end
  
  def write__UI24(value, position = nil)
    seek position unless position.nil?
    write [value >> 16].pack('c')
    write [(value >> 8) & 0xff].pack('c')
    write [value & 0xff].pack('c')
  end
  
  def write__UI32(value, position = nil)
    seek position unless position.nil?
    write [value].pack('N')
  end
  
  def write__STRING(string, position = nil)
    seek position unless position.nil?
    write string
  end
end
