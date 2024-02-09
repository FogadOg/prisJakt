module TextProcessing
    class TextProcess
        def initialize(sentence)
            @sentence=sentence

        end
        
        def process()
            return unless @sentence

            removeSpecialChars = @sentence.gsub(/[^0-9A-Za-z]/, ' ')
            return unless removeSpecialChars
        
            turnUpperToLowerCase = removeSpecialChars.downcase
            return turnUpperToLowerCase.gsub('  ', ' ')
        end
    end
end  