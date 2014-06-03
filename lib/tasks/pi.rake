def execute_command(command)
  puts command
  puts %x[#{command}]
end

namespace :pi do

  namespace :db do

    desc "Pull production DB into development"
    task :pull => :environment do
      db_configs = YAML.load_file("config/database.yml").with_indifferent_access
      timestamp = Time.now.strftime "%Y%m%d%H%M%S"
      dumpfile_name = "tmp/pi-production-#{timestamp}.pgdump.gz"
      execute_command "ssh piersonally.com '/usr/local/bin/pg_dump --clean piersonally_production | gzip' > #{dumpfile_name}"
      execute_command "gzcat #{dumpfile_name} | psql #{db_configs[:development][:database]}"
    end
  end
end
