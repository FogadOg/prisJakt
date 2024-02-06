module Search
    class TextProcess
        def initialize(sentance)
            @sentance=sentance
        end
        
        def process()
            removeSepcialChars=(@sentance.gsub!(/[^0-9A-Za-z]/, ' ')).gsub!('  ', ' ')
            return removeSepcialChars.downcase
        end
    end
end