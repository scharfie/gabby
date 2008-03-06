class Hash
  def method_missing(m, *args)
    self[m] if has_key?(m)
  end
end

class Object
  def try(method)
    send method if respond_to?(method)
  end
end