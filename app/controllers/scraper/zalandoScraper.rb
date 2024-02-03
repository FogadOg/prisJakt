require 'nokogiri'
require 'open-uri'

module Scraper
    class ZalandoScraper < BaseScraper
        def initialize(url)
            super(url)
            scrape()
        end
        
        def scrape

            pageHtml=ScraperUtil.new(@doc)
            products=pageHtml.getProducts("._5qdMrS.w8MdNG.cYylcv.BaerYO._75qWlu.iOzucJ.JT3_zV._Qe9k6")
            
            products.save(
                '//section[@class="_0xLoFW _78xIQ-"]//span',
                "._LM.JT3_zV.CKDt_l.CKDt_l.LyRfpJ",
                ".sDq_FX.lystZ1.FxZV-M.HlZ_Tf.ZkIJC-.r9BRio.qXofat.EKabf7.nBq1-s._2MyPg2",
                ".sDq_FX.lystZ1.FxZV-M._2Pvyxl.JT3_zV.EKabf7.mo6ZnF._1RurXL.mo6ZnF._7ZONEy"               
            )

        end
        
    end
end
