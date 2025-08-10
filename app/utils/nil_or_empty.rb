module Utils
    def self.nil_or_empty?(value)
        return value.nil? || (value.respond_to?(:empty?) && value.empty?)
    end
end