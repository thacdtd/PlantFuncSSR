# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( browse_microsatellite/browse_microsatellites.js )
Rails.application.config.assets.precompile += %w( markers_list/markers_list.js )
Rails.application.config.assets.precompile += %w( summary_report/summary_report.js )
Rails.application.config.assets.precompile += %w( welcome/welcome.js )
Rails.application.config.assets.precompile += %w( browse_microsatellite/browse_main.js )
Rails.application.config.assets.precompile += ['jquery.js', 'jquery_ujs.js', 'turbolinks.js', 'jquery.dataTables.min.js',
   'dataTables.bootstrap.min.js', 'dataTables.tableTools.js', 'dataTables.buttons.min.js', 'jszip.min.js', 'pdfmake.min.js', 
   'vfs_fonts.js', 'buttons.html5.min.js', 'highcharts.js', 'exporting.js', 'chosen.jquery.js', 'chosen.css']