require 'sass/tree/node'

module Sass::Tree
  class CommentNode < Node
    attr_accessor :value

    def initialize(value, silent)
      @value = value[2..-1].strip
      @silent = silent
      super()
    end

    def options=(options)
      @options = options
    end

    def ==(other)
      self.value == other.value && super
    end

    def to_s(tabs = 0, parent_name = nil)
      return if (style == :compressed || @silent)

      spaces = '  ' * (tabs - 1)
      spaces + "/* " + ([value] + children.map {|c| c.text}).
        map{|l| l.sub(%r{ ?\*/ *$},'')}.join(style == :compact ? ' ' : "\n#{spaces} * ") + " */"
    end

    protected

    def _perform(environment)
      self
    end
  end
end
