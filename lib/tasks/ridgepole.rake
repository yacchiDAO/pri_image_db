namespace :ridgepole do
  desc "Apply database schema"
  task apply: :environment do
    ridgepole("--apply", "--file #{schema_file}")
    Rake::Task["db:schema:dump"].invoke
  end

  desc "Apply database schema for heroku"
  task apply_heroku: :environment do
    ridgepole_heroku("--apply", "--file #{schema_file}")
    Rake::Task["db:schema:dump"].invoke
  end

  desc "Export database schema"
  task export: :environment do
    ridgepole("--export", "--output #{schema_file}")
  end

  private

    def schema_file
      Rails.root.join("db/Schemafile")
    end

    def config_file
      Rails.root.join("config/database.yml")
    end

    def config_file_heroku
      uri = URI.parse(ENV.fetch("DATABASE_URL", nil))

      raise "Invalid uri: #{uri}" if [uri.scheme, uri.user, uri.password, uri.host, uri.path].any?(&:nil?)

      uri.scheme = "postgresql" if uri.scheme == "postgres"

      "'{
      adapter:  #{uri.scheme},
      username: #{uri.user},
      password: #{uri.password},
      host:     #{uri.host},
      database: #{uri.path.sub(%r{\A/}, "")},
    }'"
    end

    def ridgepole(*options)
      command = ["bundle exec ridgepole", "--config #{config_file}"]
      system [command + options].join(" ")
    end

    def ridgepole_heroku(*options)
      command = ["bundle exec ridgepole", "--config #{config_file_heroku}"]
      system [command + options].join(" ")
    end
end
