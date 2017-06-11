Pod::Spec.new do |s|
  s.name         = "ALRT"
  s.version      = "0.6"
  s.summary      = "ALRT is an easy-to-create UIAlertController framework."
  s.description  = <<-DESC
                     * Easy-to-Create. as easy as 'ALRT.create(.alert).addOK().show()''
                     * Chainable
                     * Can add UITextField(s) and handle their values when a certain UIAlertAction button is clicked.
                     * Can handle the result of show() action both .success and .failure
                     DESC

  s.homepage     = "https://github.com/mshrwtnb/ALRT"
  s.screenshots  = "https://raw.githubusercontent.com/wiki/mshrwtnb/ALRT/logobanner.png"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Masahiro Watanabe" => "iammshr@gmail.com" }
  s.social_media_url   = "http://qiita.com/mshrwtnb"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/mshrwtnb/ALRT.git", :tag => "v#{s.version}" }
  s.source_files  = "ALRT/*.swift"
  s.requires_arc = true
end
