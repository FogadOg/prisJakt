class CreateScrapeRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :scrape_records do |t|
      t.date :date

      t.timestamps
    end
  end
end
