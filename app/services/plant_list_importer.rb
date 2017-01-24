require 'csv'

class PlantListImporter
  def initialize(directory)
    @directory = directory
  end

  def perform
    Dir.glob(directory) do |file|
      puts "Importing #{File.basename(file)} ..."

      total = imported = 0
      CSV.foreach(file, headers: true) do |row|
        total += 1
        begin
          family = Family.create_with(
            major_group: parse_major_group(row['Major group'])
          ).find_or_create_by!(name: row['Family'].try(:strip).downcase)

          genus = Genus.create_with(
            family: family,
            hybrid: row['Genus hybrid marker'].present?
          ).find_or_create_by!(name: row['Genus'].try(:strip).downcase)

          Species.create_with(
            authorship: row['Authorship'].try(:strip),
            source: row['Source'].try(:strip),
            source_id: row['Source id'].try(:strip),
            combined_source_id: row['ID'].try(:strip),
            ipni_id: row['IPNI id'].try(:strip),
            publication: row['Publication'].try(:strip),
            collation: row['Collation'].try(:strip),
            date: row['Date'].present? ? row['Date'].to_i : nil,
            taxonomic_status: parse_taxonomic_status(row['Taxonomic status in TPL']),
            confidence_level: parse_confidence_level(row['Confidence level']),
            hybrid: row['Species hybrid marker'].present?
          ).find_or_create_by!(
            name: row['Species'].try(:strip).downcase,
            genus: genus,
            infraspecific_rank: row['Infraspecific rank'].try(:strip),
            infraspecific_epithet: row['Infraspecific epithet'].try(:strip)
          )
          imported += 1
        rescue => e
          puts "E: #{e.inspect}".red
        end
      end

      puts "imported #{imported} of #{total}"
    end
  end

  private

  def directory
    if @directory.downcase.end_with? '.csv'
      @directory
    else
      "#{@directory}/*.csv"
    end
  end

  def parse_major_group(str)
    case str.try(:strip)
      when 'A' then :angiosperms
      when 'G' then :gymnosperms
      when 'P' then :pteridophytes
      when 'B' then :bryophytes
      else nil
    end
  end

  def parse_taxonomic_status(str)
    str.strip.downcase.to_sym
  end

  def parse_confidence_level(str)
    case str.try(:strip)
      when 'H' then :high
      when 'M' then :medium
      when 'L' then :low
      else nil
    end
  end
end
