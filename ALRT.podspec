Pod::Spec.new do |s|
  s.name         = "ALRT"
  s.version      = "1.3.6"
  s.summary      = "An easier constructor for UIAlertController. Present from anywhere."
  s.homepage     = "https://github.com/mshrwtnb/ALRT"
  s.screenshots  = "https://raw.githubusercontent.com/wiki/mshrwtnb/ALRT/logobanner.png"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Masahiro Watanabe" => "iammshr@gmail.com" }
  s.social_media_url   = "https://mshrwtnb.com/"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/mshrwtnb/ALRT.git", :tag => "#{s.version}" }
  s.source_files  = "ALRT/*.swift"
  s.requires_arc = true
end
