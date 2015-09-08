
class Globals
  # This function allows you to create a class variable with a given default
  # value, and provide accesssors to that variable. Insane.
  class << self
    def field(name, default)
      instance_variable_set("@#{name}", default)
      class << self; self; end.instance_eval { attr_accessor name }
    end
  end

  # List of fields, and their default values
  field :bar, 666
  field :foo, 1
end

puts "bar = #{Globals.bar}"
Globals.bar = :goodbye
puts "bar = #{Globals.bar}"
