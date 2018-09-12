def generate(visibility, zones, version, own_vpc)
  template "#{version}-#{own_vpc ? 'own-vpc' : 'new-vpc'}-#{visibility}-#{zones}az.yaml" do
    source "sentry-formation.yaml.erb"
    variables(
      Description: "Sentry.io #{visibility} setup in #{zones} availability zones",
      visibility: visibility,
      availability_zones: zones,
      version: version,
      own_vpc: own_vpc
    )
  end
end

def get_version()
  File.foreach('Releases.md').first.match(/[0-9.]+/)[0]
end

[get_version(), 'master'].each do |version|
  ["internal", "internet-facing"].each do |visibility|
    [true, false].each do |own_vpc|
      (2..3).each do |zones|
        generate(visibility, zones, version, own_vpc)
      end
    end
  end
end
