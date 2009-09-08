#--
# Copyright (c) 2005-2009, John Mettraux, jmettraux@gmail.com
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# Made in Japan.
#++


require 'ruote/exp/flowexpression'
require 'ruote/exp/command'


module Ruote::Exp

  #
  # This class gathers the 'skip', 'back', 'jump', 'rewind', 'continue' and
  # 'break' expressions which are used inside of the 'cursor' and 'repeat'
  # (loop) expressions.
  #
  # Look at the 'cursor' expression Ruote::Exp::Cursor for a discussion of
  # each of those [sub]expressions.
  #
  class CommandExpression < FlowExpression

    include CommandMixin

    names :skip, :back, :jump, :rewind, :continue, :break

    def apply

      param = case name
      when 'skip', 'back' then attribute(:step) || attribute_text
      when 'jump' then attribute(:to) || attribute_text
      else nil
      end

      param = Integer(param) rescue param

      set_command(@applied_workitem, name, param)

      reply(@applied_workitem)
    end
  end
end

