# StrawServiceHttp.podspec

Pod::Spec.new do |s|

  s.name         = "StrawServiceHttp"

  s.version      = "0.0.3"

  s.summary      = "Straw Service of Http"

  s.description  = "Straw Service implementation of Http client methods"

  s.homepage     = "https://github.com/strawjs/straw-ios-service-http"

  s.license      = {
      :type => "MIT",
      :file => "LICENSE"
  }
  
  s.author       = { "Yoshiya Hinosawa" => "stibium121@gmail.com" }

  s.platform     = :ios, "5.0"

  s.source       = { :git => "https://github.com/strawjs/straw-ios-service-http.git", :tag => "0.0.3" }

  s.source_files = "StrawServiceHttp/**/*.{h,m}"

  s.public_header_files = "StrawServiceHttp/**/*.h"

  s.dependency "Straw", "~> 0.4.0"

  s.requires_arc  = true

end
