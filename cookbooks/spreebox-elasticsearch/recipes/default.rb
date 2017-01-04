elasticsearch_user "spreeboxelastic"

elasticsearch_install "spreeboxelastic" do
  type "package"
  version "5.1.1"
  download_url "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.1.1.deb"
  download_checksum "c8a38990a24b558fb9c65492034caa00044e638d0ede6d440b00cb4eacb46d1d"
  action "install"
end

elasticsearch_configure "spreeboxelastic" do
  allocated_memory "256m"
  configuration ({
    "cluster.name" => "spreeboxescluster",
    "node.name" => "node01",
    "network.host" => "0.0.0.0"
  })
end

elasticsearch_service "spreeboxelastic"
