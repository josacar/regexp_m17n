module RegexpM17N
  def self.non_empty?(str)
    String.class_eval do
      def encode(string)
        ec = Encoding::Converter.new(self.encoding, string)
        ec.convert(self)
      rescue Encoding::ConverterNotFoundError
        self.force_encoding(string)
      end
    end

    regexp = '^.+$'
    encoding = Encoding.find(str.encoding)

    string = if encoding.dummy?
      str.encode('UTF-8')
    else
      regexp = regexp.encode(str.encoding)
      str
    end
    regexp = Regexp.new(regexp)

    regexp =~ string
  end
end
