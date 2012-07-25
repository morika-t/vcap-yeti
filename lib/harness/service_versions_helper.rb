
module BVT::Spec

  TESTED_SERVICES = [{:vendor => 'mongodb', :versions => %w(1.8 2.0)}]


  MYSQL_MANIFEST      = ENV['VCAP_BVT_MYSQL_MANIFEST'] ? eval(ENV['VCAP_BVT_MYSQL_MANIFEST']) :
                                                        {:vendor=>"mysql", :version=>"5.1"}
  REDIS_MANIFEST      = ENV['VCAP_BVT_REDIS_MANIFEST'] ? eval(ENV['VCAP_BVT_REDIS_MANIFEST']) :
                                                        {:vendor => "redis", :version=>"2.2"}
  MONGODB_MANIFEST    = ENV['VCAP_BVT_MONGODB_MANIFEST'] ? eval(ENV['VCAP_BVT_MONGODB_MANIFEST']) :
                                                        {:vendor => "mongodb", :version=>"1.8"}
  RABBITMQ_MANIFEST   = ENV['VCAP_BVT_RABBITMQ_MANIFEST'] ? eval(ENV['VCAP_BVT_RABBITMQ_MANIFEST']) :
                                                        {:vendor => "rabbitmq", :version=>"2.4"}
  POSTGRESQL_MANIFEST = ENV['VCAP_BVT_POSTGRESQL_MANIFEST'] ? eval(ENV['VCAP_BVT_POSTGRESQL_MANIFEST']) :
                                                        {:vendor => "postgresql", :version=>"9.0"}
  NEO4J_MANIFEST      = ENV['VCAP_BVT_NEO4J_MANIFEST'] ? eval(ENV['VCAP_BVT_NEO4J_MANIFEST']) :
                                                        {:vendor => "neo4j", :version=>"1.4"}
  VBLOB_MANIFEST      = ENV['VCAP_BVT_VBLOB_MANIFEST'] ? eval(ENV['VCAP_BVT_VBLOB_MANIFEST']) :
                                                        {:vendor => "vblob", :version=>"1.0"}
  MEMCACHED_MANIFEST  = ENV['VCAP_BVT_MEMCACHED_MANIFEST'] ? eval(ENV['VCAP_BVT_MEMCACHED_MANIFEST']) :
                                                        {:vendor => "memcached",:version=>"1.4"}
  COUCHDB_MANIFEST    = ENV['VCAP_BVT_COUCHDB_MANIFEST'] ? eval(ENV['VCAP_BVT_COUCHDB_MANIFEST']) :
                                                        {:vendor => "couchdb",:version=>"1.2"}
  ELASTICSSEARCH_MANIFEST   = ENV['VCAP_BVT_ELASTICSSEARCH_MANIFEST'] ? eval(ENV['VCAP_BVT_ELASTICSSEARCH_MANIFEST']) :
                                                        {:vendor  =>  "elasticsearch", :version=>"0.19"}

  SERVICES_MANIFEST = [MYSQL_MANIFEST, REDIS_MANIFEST, MONGODB_MANIFEST, RABBITMQ_MANIFEST,
                       POSTGRESQL_MANIFEST, NEO4J_MANIFEST, VBLOB_MANIFEST, MEMCACHED_MANIFEST,
                       COUCHDB_MANIFEST, ELASTICSSEARCH_MANIFEST]

  module ServiceVersions
    module_function

    def get_tested_services()
      SERVICES_MANIFEST.each do |manifest|
        TESTED_SERVICES.each do |m|
          next unless m[:vendor] == manifest[:vendor]
          m[:versions].delete(manifest[:version])
        end
      end
      TESTED_SERVICES.delete_if {|x| x[:versions].empty?}
    end

    def set_environment_variables(envs)
      res = {}
      case envs[:vendor]
        when 'mysql'
          res["VCAP_BVT_MYSQL_MANIFEST"] = envs.to_s
        when 'postgresql'
          res["VCAP_BVT_POSTGRESQL_MANIFEST"] = envs.to_s
        when 'mongodb'
          res["VCAP_BVT_MONGODB_MANIFEST"] = envs.to_s
        when 'redis'
          res["VCAP_BVT_REDIS_MANIFEST"] = envs.to_s
        when 'rabbitmq'
          res["VCAP_BVT_RABBITMQ_MANIFEST"] = envs.to_s
        when 'vblob'
          res["VCAP_BVT_VBLOB_MANIFEST"] = envs.to_s
        when 'memcached'
          res["VCAP_BVT_MEMCACHED_MANIFEST"] = envs.to_s
        when 'couchdb'
          res["VCAP_BVT_COUCHDB_MANIFEST"] = envs.to_s
        when 'elasticsearch'
          res["VCAP_BVT_ELASTICSEARCH_MANIFEST"] = envs.to_s
        else
          raise RuntimeError, "service vendor: #{envs[:vendor]}," +
              " is not supported to set proper Environment variables. "
      end
      res
    end
  end
end
