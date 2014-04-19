class Class
  def bool_attr_accessor(*my_accessors)
    my_accessors.each do |accessor|
      define_method(("#{accessor}?").to_sym) do
        !!instance_variable_get("@#{accessor}") #rubocop:disable DoubleNegation
      end

      define_method("#{accessor}=") do |accessor_value|
        instance_variable_set("@#{accessor}", accessor_value)
      end
    end
  end
end
