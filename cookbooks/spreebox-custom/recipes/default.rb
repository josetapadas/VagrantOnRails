hostsfile_entry '0.0.0.0' do
  hostname 'lola.dev'
  action :create
end

execute "chown-vagrant" do
  command "chown -R vagrant:vagrant /opt/"
  user "vagrant"
  action :nothing
end
