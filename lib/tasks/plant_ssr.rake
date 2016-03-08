namespace :plant_ssr do

  desc "Import families"
  task :import_families => :environment do
    Admin::FamiliesImporter.import_families
    p "Import succeeded"
  end
  
  task :import_NGS_families => :environment do
    Admin::FamiliesImporter.import_NGS_families
    p "Import succeeded"
  end
  
  task :import_NGS_families2 => :environment do
    Admin::FamiliesImporter.import_NGS_families2
    p "Import succeeded"
  end
  
  task :import_annotations => :environment do
    Admin::FamiliesImporter.import_annotations
    p "Import succeeded"
  end
  
  task :import_ssrs => :environment do
    Admin::FamiliesImporter.import_ssrs
    p "Import succeeded"
  end
  
  task :import_statistic => :environment do
    Admin::FamiliesImporter.import_statistic
    p "Import succeeded"
  end
  
  task :import_statistic2 => :environment do
    Admin::FamiliesImporter.import_statistic2
    p "Import succeeded"
  end
  
  task :test_import => :environment do
    Admin::FamiliesImporter.test_import
    p "Import succeeded"
  end
  
  task :add_has_primer_to_ssr => :environment do
    Admin::FamiliesImporter.add_has_primer_to_ssr
    p "Finish add"  
  end
  
  task :add_has_annotation_to_ssr => :environment do
    Admin::FamiliesImporter.add_has_annotation_to_ssr
    p "Finish add"  
  end
  
  task :import_all => :environment do
    Admin::FamiliesImporter.import_families
    Admin::FamiliesImporter.import_annotations
    Admin::FamiliesImporter.import_ssrs
    Admin::FamiliesImporter.import_statistic
    Admin::FamiliesImporter.add_has_primer_to_ssr
    Admin::FamiliesImporter.add_has_annotation_to_ssr
    p "Import succeeded"
  end
  
end