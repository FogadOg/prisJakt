module Search
    class TfIdfVector
      def initialize()
        @vector = []
      end
  
      def generateTfIdfVector(tfIdfClass, sentence)
        termList = sentence.split
  
        termList.each do |word| 
          tfIdfScore = tfIdfClass.tfIdf(word)
          @vector.append(tfIdfScore)
        end
      end
  
      def cosineSimilarity(otherTfIdfVector)
        raise "vectors must be same size" unless @vector.length == otherTfIdfVector.length
  
        dotProductA = _dotProduct(@vector, otherTfIdfVector.vector)
        dotProductB = _dotProduct(otherTfIdfVector.vector, @vector)
  
        magnitudeA = _euclideanNorm(@vector)
        magnitudeB = _euclideanNorm(otherTfIdfVector.vector)

        similarity=(dotProductA * dotProductB) / (magnitudeA * magnitudeB)
        if similarity==NaN
            return 0
        end
        return similarity
      end
  
      def _dotProduct(vectorA, vectorB)
        dotProduct = 0
  
        vectorA.each_with_index do |val, idx|
          dotProduct += val * vectorB[idx]
        end
  
        return dotProduct
      end
  
      def _euclideanNorm(vector)
        return Math.sqrt(vector.map { |x| x**2 }.reduce(:+))
      end
  
      def length
        return @vector.length
      end
  
      def addToVector(score)
        @vector.append(score)
      end
  
      def vector
        @vector
      end
    end
  end
  