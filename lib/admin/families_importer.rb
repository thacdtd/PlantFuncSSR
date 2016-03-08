require 'rubygems'
require 'open-uri'
require 'spreadsheet'

module Admin
  module FamiliesImporter
    def self.import_families
      p "import"
      rows = Array.new
      temp_rows = Array.new
      column_headers = Array.new
      index = 0
      doc = Spreadsheet.open("lib/tasks/Species_and_Family_names.xls")
      sheet1 = doc.worksheet 0
      sheet1.each do |row|
         rows << row.to_a
      end

      for i in 1..(rows.length-1) do
        family = Family.where(:name => rows[i][1].gsub(/\s+/, "")).first_or_create()
        Species.where(:name => rows[i][0].split(".")[0]).first_or_create(:family_id => family.id)
      end
    end
    
    def self.import_NGS_families
      p "import NGS"
      rows = Array.new
      temp_rows = Array.new
      column_headers = Array.new
      index = 0
      doc = Spreadsheet.open("lib/tasks/NGS_Transcript_Assemblies.xls")
      sheet1 = doc.worksheet 0
      sheet1.each do |row|
         rows << row.to_a
      end

      for i in 1..(rows.length-1) do
        family = Family.where(:name => rows[i][1].gsub(/\s+/, "")).first_or_create(:kind => "NGS")
        Species.where(:name => rows[i][0].split(".")[0]).first_or_create(:family_id => family.id)
      end
    end
    
    def self.import_NGS_families2
      p "import NGS 2"
      rows = Array.new
      temp_rows = Array.new
      column_headers = Array.new
      index = 0
      doc = Spreadsheet.open("lib/tasks/NGS_Transcript_Assemblies.xls")
      sheet1 = doc.worksheet 1
      sheet1.each do |row|
         rows << row.to_a
      end

      for i in 1..(rows.length-1) do
        if rows[i][2].gsub(/\s+/, "") == "v3"
          family = Family.where(:name => rows[i][1].gsub(/\s+/, "")).first_or_create(:kind => "NGS assembly")
          Species.where(:name => rows[i][0].split(".")[0]).first_or_create(:family_id => family.id)
        end
      end
    end
    

    def self.import_annotations
      Dir.chdir("/home/ubuntu/results/annot")
      Dir.glob("*.annot") {|file_name|
        # do something with the file here
        species = Species.where(:name => file_name.split(".")[0]).first
        unless species.nil?
          p species
          file = open(file_name)
          file_content = file.read
          arr_file_content = file_content.split(/\r?\n/)
          arr_file_content.each do |row|
            element = row.split(/\r?\t/)
            anno = Annotation.where(:name => element[0]).first_or_create(:species_id => species.id,
                                                                       :MPG_name => element[1],
                                                                       :MPG_description => element[2],
                                                                      :Goterm => element[3],
                                                                      :UnitProt => element[4],
                                                                      :InterPro => element[5])
          end
        end
      }
    end

    def self.import_ssrs
      Dir.chdir("/home/ubuntu/results/ssr")
      Dir.glob("*.results") {|file_name|
        # do something with the file here
        species = Species.where(:name => file_name.split(".")[0]).first
        unless species.nil?
          p species
          file = open(file_name)
          file_content = file.read
          if ! file_content.valid_encoding?
            file_content = file_content.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
          end
          arr_file_content = file_content.split(/\r?\n/)
          arr_file_content.drop(1).each do |row|
            element = row.split(/\r?\t/)
            _anno = Annotation.where(:name => ssr_name).first
            has_anno = false
            unless _anno.nil?
              anno_id = _anno.id
              has_anno = true
            end
            ssr = Ssr.create(:species_id => species.id,
                      :SSR_ID => element[0],
                      :SSR_nr => element[1],
                      :SSR_type => element[2],
                      :SSR => element[3],
                      :size => element[4],
                      :start => element[5],
                      :end => element[6],
                      :has_primer => false,
                      :has_annotation => has_anno,
                      :annotation_id => anno_id)
            if element.length == 34
              ssr.has_primer = true
              ssr.save
              Primer1.create(:ssr_id => ssr.id,
                              :Forward => element[7],
                              :FP_Tm => element[8],
                              :FP_Size => element[9],
                              :Reverse => element[10],
                              :RP_Tm => element[11],
                              :RP_Size => element[12],
                              :Product_Size => element[13],
                              :Start => element[14],
                              :End => element[15])
              Primer2.create(:ssr_id => ssr.id,
                              :Forward => element[16],
                              :FP_Tm => element[17],
                              :FP_Size => element[18],
                              :Reverse => element[19],
                              :RP_Tm => element[20],
                              :RP_Size => element[21],
                              :Product_Size => element[22],
                              :Start => element[23],
                              :End => element[24])
              Primer3.create(:ssr_id => ssr.id,
                              :Forward => element[25],
                              :FP_Tm => element[26],
                              :FP_Size => element[27],
                              :Reverse => element[28],
                              :RP_Tm => element[29],
                              :RP_Size => element[30],
                              :Product_Size => element[31],
                              :Start => element[32],
                              :End => element[33])
            end
          end
        end
      }
    end

    def self.import_statistic
      Dir.chdir("/home/ubuntu/results/ssr")
      Dir.glob("*.statistics") {|file_name|
        species = Species.where(:name => file_name.split(".")[0]).first
        unless species.nil?
          p species
          file = open(file_name)
          file_content = file.read
          arr_file_content = file_content.split(/\r?\n/)
          Statistic.where(:species_id => species.id).first_or_create(:Num_Seqs_Exam => arr_file_content[15].split(/\r?\b/).last,
                                                                    :Size_Exam_Seqs => arr_file_content[16].split(/\r?\b/).last,
                                                                    :Num_SSR_Indent => arr_file_content[17].split(/\r?\b/).last,
                                                                    :SSR_Cont_Seqs => arr_file_content[18].split(/\r?\b/).last,
                                                                    :Seqs_Cont_SSR => arr_file_content[19].split(/\r?\b/).last,
                                                                    :Num_SSR_Present => arr_file_content[20].split(/\r?\b/).last,
                                                                    :Mono => arr_file_content[27].split(/\r?\b/).last,
                                                                    :Di => arr_file_content[28].split(/\r?\b/).last,
                                                                    :Tri => arr_file_content[29].split(/\r?\b/).last,
                                                                    :Tetra => arr_file_content[30].split(/\r?\b/).last,
                                                                    :Penta => arr_file_content[31].split(/\r?\b/).last,
                                                                    :Hexa => arr_file_content[32].split(/\r?\b/).last)
        end
      }
    end
    
    def self.import_statistic2
      p "import statistics 2"
      Dir.chdir("/home/gaurav/PlantSSR/new_statistic/")
      Dir.glob("*.statistic") {|file_name|
        species = Species.where(:name => file_name.split(".")[0]).first
        unless species.nil?
          p species
          file = open(file_name)
          file_content = file.read
          arr_file_content = file_content.split(/\r?\n/)
          Statistic.where(:species_id => species.id).first_or_create(:Num_Seqs_Exam => arr_file_content[15].split(/\r?\b/).last,
                                                                    :Size_Exam_Seqs => arr_file_content[16].split(/\r?\b/).last,
                                                                    :Num_SSR_Indent => arr_file_content[17].split(/\r?\b/).last,
                                                                    :SSR_Cont_Seqs => arr_file_content[18].split(/\r?\b/).last,
                                                                    :Seqs_Cont_SSR => arr_file_content[19].split(/\r?\b/).last,
                                                                    :Num_SSR_Present => arr_file_content[20].split(/\r?\b/).last,
                                                                    :Mono => arr_file_content[27].split(/\r?\b/).last,
                                                                    :Di => arr_file_content[28].split(/\r?\b/).last,
                                                                    :Tri => arr_file_content[29].split(/\r?\b/).last,
                                                                    :Tetra => arr_file_content[30].split(/\r?\b/).last,
                                                                    :Penta => arr_file_content[31].split(/\r?\b/).last,
                                                                    :Hexa => arr_file_content[32].split(/\r?\b/).last)
        end
      }
    end
    

    def self.test_import
      ssr_list = Ssr.all
      arr_number = []
      ssr_list.each do |ssr|
        arr_number << ssr.SSR.scan(/\d/).join(',').split(",").max
      end
      p arr_number
    end

    def self.add_has_primer_to_ssr
      ssr_list = Ssr.all
      ssr_list.each do |ssr|
        if check_primer(ssr.id)
          ssr.has_primer = true
        else
          ssr.has_primer = false
        end
        ssr.save()
      end
    end

    def self.add_has_annotation_to_ssr
      ssr_list = Ssr.all
      ssr_list.each do |ssr|
        if check_annotation(ssr.SSR_ID)
          ssr.has_annotation = true
        else
          ssr.has_annotation = false
        end
        ssr.save()
      end
    end

    def self.check_primer(ssr_id)
      _primer1 = Primer1.where(:ssr_id => ssr_id).first
      _primer2 = Primer2.where(:ssr_id => ssr_id).first
      _primer3 = Primer3.where(:ssr_id => ssr_id).first
      if (_primer1 == nil) && (_primer2 == nil) && (_primer3 == nil)
        return false
      end
      return true
    end

    def self.check_annotation(ssr_name)
      _anno = Annotation.where(:name => ssr_name).first
      if _anno != nil
        return true
      end
      return false
    end
  end
end
