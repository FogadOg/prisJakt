module Search
    class TextProcess
        def initialize(sentence)
            @sentence=sentence

        end
        
        def process()
            removeSepcialChars=@sentence.gsub!(/[^0-9A-Za-z]/, ' ')
            turnUpperToLowerCase=removeSepcialChars.downcase
            return turnUpperToLowerCase.gsub!('  ', ' ')
        end
    end
end