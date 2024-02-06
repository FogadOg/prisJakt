module Search
    class TfIdfVector
        def initialize(sentance)
            @sentance=sentance
            @tfIdf=TfIdf.new(sentance)

            @vector=_createVector
        end

        def _createVector
            vector=[]
            words=@sentance.split
            
            words.each do |word|
                tfIdf=@tfIdf.tfIdf(word)
                vector.append(tfIdf)
            end
            return vector
        end

        def vector
            @vector
        end

    end
end



