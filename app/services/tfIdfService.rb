require 'json'

module Service
    class TfIdfService
        def initialize(filePath)
            @filePath=filePath
        end

        def writeToFile(dictionary)
            File.open(@filePath, "w") do |file|
                return file.write(JSON.dump(dictionary))
            end
        end

        def incrementTerm(term)
            dict=readFile

            if dict.key?(term)
                dict[term] += 1
            else
                dict[term] = 1
            end
            writeToFile(dict)

        end

        def readFile
            return JSON.parse(File.read(@filePath))
        end

        def getIdfCount(term)
            dict=readFile

            if dict.key?(term)
                return dict[term]
            else
                return 0
            end
        end


    end
end

