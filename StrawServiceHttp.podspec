# StrawServiceHttp.podspec

Pod::Spec.new do |s|

  s.name         = "StrawServiceHttp"

  s.version      = "0.0.2"

  s.summary      = "Straw Service of Http"

  s.description  = "Straw Service of Http"

  s.homepage     = "https://github.com/strawjs/straw-ios-serice-http"

  s.license      = "MIT"
  
  s.author       = { "Yoshiya Hinosawa" => "stibium121@gmail.com" }

  s.source       = { :git => "https://github.com/strawjs/straw-ios-service-http.git", :tag => "0.0.1" }

  s.source_files = "StrawServiceHttp/**/*.{h,m}"

  s.public_header_files = "StrawServiceHttp/**/*.h"

  s.dependency "Straw", "~> 0.4.0"

end
