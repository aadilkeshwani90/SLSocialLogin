#
#  Be sure to run `pod spec lint SLSocialLogin.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "SLSocialLogin"
  s.version      = "0.1.1"
  s.summary      = "Hey Folks, SLSocialLogin is the new Library to integrate Facebook , Twitter, LinkedInn, Instagram Login."

  s.description  = "Hey Folks, SLSocialLogin is the new Library to integrate Facebook Login, Twitter Login, LinkedInn Login, Instagram Login and Google Plus Login with a very simple Configuration"

  s.homepage     = "http://www.icoders.in"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.icoders.in/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

s.license      = "LICENSE"



  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "aadil" => "aadil.keshwani@gmail.com" }
  # Or just: s.author    = "Aadil Keshwani"
  # s.authors            = { "aadil" => "aadil.keshwani@gmail.com" }
  # s.social_media_url   = "http://twitter.com/aadil"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # s.platform     = :ios
    s.platform     = :ios, "7.0"
#  s.libraries    =  "GooglePlus" ,
  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/aadilkeshwani90/SLSocialLogin.git", :tag => "0.1.1" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #
  s.source_files  = 'SLSocialLogin/*.{h,m}'
  s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

   s.resource  = "GooglePlus.framework"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
   s.frameworks = "GooglePlus", "linkedin-sdk", "GoogleOpenSource", "UIKit", "SystemConfiguration", "Security", "MediaPlayer", "CoreText", "CoreGraphics", "CoreMotion", "CoreLocation", "Foundation", "AssetsLibrary", "AddressBook"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

# s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/SLSocialLogin" }
  # s.dependency "JSONKit", "~> 1.4"
    s.dependency "FBSDKCoreKit"
    s.dependency 'FBSDKLoginKit'
    s.dependency 'FBSDKShareKit'
    s.dependency 'InstagramKit'
    s.dependency 'MBProgressHUD'
    s.dependency 'FHSTwitterEngine'
end
