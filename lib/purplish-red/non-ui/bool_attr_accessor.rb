class Class
  # Returns the list of method names (symbols) generated. Useful for making them private
  def bool_attr_accessor(*my_accessors)
    method_names = []
    my_accessors.each do |accessor|
      name = ("#{accessor}?").to_sym
      method_names << name
      define_method(name) do
        !!instance_variable_get("@#{accessor}") #rubocop:disable DoubleNegation
      end

      name = "#{accessor}=".to_sym
      method_names << name
      define_method(name) do |accessor_value|
        instance_variable_set("@#{accessor}", accessor_value)
      end
    end
    method_names
  end
end
