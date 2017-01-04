include_recipe "postgresql::server"
include_recipe "postgresql::client"

include_recipe "database::postgresql"

puts node['postgresql']['password']['postgres']

postgresql_connection_info = {
  :host     => '0.0.0.0',
  :port     => node['postgresql']['config']['port'],
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

postgresql_database_user "vagrant" do
  connection postgresql_connection_info
  password "vagrant"
  action [ :create ]
end
