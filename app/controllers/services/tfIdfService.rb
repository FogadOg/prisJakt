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
            dict=readFromFile

            if dict.key?(term)
                dict[term] += 1
            else
                dict[term] = 1
            end
            writeToFile(dict)

        end

        def readFromFile
            return JSON.parse(File.read("idfCount.json"))
        end


    end
end

