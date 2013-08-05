Gem::Specification.new do |s|
  s.name        = 'chloroplast'
  s.version     = '0.1.2'
  s.license     = 'GPL'
  s.summary     = "A DSL for creating objects using a tabular format"
  s.description = "Chloroplast provides a DSL for creating objects using a tabular format. The table’s headers become objects’ attribute names, and each row of the table defines one object’s attribute values."
  s.authors     = ["Yaohan Chen"]
  s.email       = 'yaohan.chen@gmail.com'
  s.files       = Dir["lib/**/*.rb", "spec/**/*.rb"]
  s.homepage    = 'https://github.com/hagabaka/chloroplast'
end
