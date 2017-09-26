Pod::Spec.new do |s|
  s.name         = "ALRT"
  s.version      = "1.0"
  s.summary      = "ALRT is an easy-to-create UIAlertController framework."
  s.description  = <<-DESC
                     * Easy-to-Create. As easy as 'ALRT.create(.alert).addOK().show()''
                     * UITextField(s) can be added and handled.
                     DESC

  s.homepage     = "https://github.com/mshrwtnb/ALRT"
  s.screenshots  = "https://raw.githubusercontent.com/wiki/mshrwtnb/ALRT/logobanner.png"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Masahiro Watanabe" => "iammshr@gmail.com" }
  s.social_media_url   = "http://qiita.com/mshrwtnb"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/mshrwtnb/ALRT.git", :tag => "v#{s.version}" }
  s.source_files  = "ALRT/*.swift"
  s.requires_arc = true
end
