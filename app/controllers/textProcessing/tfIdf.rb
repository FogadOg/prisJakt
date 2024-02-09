require_relative '../services/tfIdfService'


module TextProcessing
    class TfIdf
      def initialize(sentence)
        @sentence = sentence
        @wordsList = @sentence.split
        @overallTermCount = @wordsList.length
        @termCount = _termCount(sentence)
      end
  
      def tf(term)
        termCount=@termCount[term].to_f
        return termCount / @overallTermCount
      end

      def idf(term)
        idf_count = Service::TfIdfService.new("idfCount.json").getIdfCount(term)
        numberOfProducts = Product.count
      
        if idf_count == 0
          return Math.log(numberOfProducts)
        elsif idf_count.nil?
          return 0
        else
          return Math.log(numberOfProducts.to_f / idf_count)
        end
      end
  
      def tfIdf(term)
        tf= tf(term)
        idf= idf(term)
        
        return tf*idf
      end
  
      def _termCount(sentence)
        termCount = {}
        @wordsList.each do |word|
          if termCount.key?(word)
            termCount[word] += 1
          else
            termCount[word] = 1
          end
        end
        return termCount
      end
  
    end
  end
  