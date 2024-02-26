module ScraperComponent::Scraper
    class ZalandoScraper < BaseScraper
        def initialize(url, searchTerm)
            super(url, searchTerm)
            scrape()
        end
        
        def scrape

            pageHtml=ScraperComponent::ScraperUtil.new(@doc)

            logo=pageHtml.getLogo("link[rel='apple-touch-icon']")

            products=pageHtml.getProducts("._5qdMrS.w8MdNG.cYylcv.BaerYO._75qWlu.iOzucJ.JT3_zV._Qe9k6")
            
            ScraperComponent::ProcessProducts.new(products.element, logo).save(
                "._LM.JT3_zV.CKDt_l.CKDt_l.LyRfpJ",
                ".sDq_FX.lystZ1.FxZV-M._2Pvyxl.JT3_zV.EKabf7.mo6ZnF._1RurXL.mo6ZnF._7ZONEy",               
                ".sDq_FX.lystZ1.FxZV-M.HlZ_Tf.ZkIJC-.r9BRio.qXofat.EKabf7.nBq1-s._2MyPg2",
                "span.sDq_FX.lystZ1",
                logo,)

        end
        
    end
end
