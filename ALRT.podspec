Pod::Spec.new do |s|
  s.name         = "ALRT"
  s.version      = "0.2"
  s.summary      = "ALRT is a call-site-friendly UIAlertController framework."
  s.description  = <<-DESC
                     ALRT aims to be an AL(R)Ternative to tedious UIAlertController implementation process.
                     - Call-site-friendly. See Github Usages
                     - Chainable UIAlertController setup both Alert and ActionSheet styles
                     - Add UITextField(s) and handle when a certain UIAlertAction button is clicked
                     - Preferred Action Support
                     - Can handle the result of show() action both .Success and .Failure
                     DESC

  s.homepage     = "https://github.com/mshrwtnb/ALRT"
  s.screenshots  = "https://raw.githubusercontent.com/wiki/mshrwtnb/ALRT/logobanner.png"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Masahiro Watanabe" => "m@nsocean.org" }
  s.social_media_url   = "http://qiita.com/mshrwtnb"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/mshrwtnb/ALRT.git", :tag => "v#{s.version}" }
  s.source_files  = "ALRT/*.swift"
  s.requires_arc = true
end
