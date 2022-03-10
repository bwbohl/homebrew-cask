cask "oxygen-xml-editor" do
  arch = Hardware::CPU.intel? ? "" : "-aarch64"
  
  version "24.0,2022012607"
  
  if #{arch} == ""
    if MacOS.version <= :el_capitan
      java = ""
      sha356 3ddd9594ae707e2cf6ec18ffa28f6eb5049b8326982edc86b2e3933b77f77d14
    else
      java = "-openjdk"
      sha356 5a2e2286e9384abef5997c9ba9737bdbaec5c7a148b7d396f9653f96381b7eaa
    end
  else
    java = "-openjdk"
    sha256 9d6d10ca7d0a64ebead0c1f56516da6784626d6071abb862dc3cab8a3239d5d8
  end

  url "https://www.oxygenxml.com/InstData/Editor/MacOSX/VM/oxygen#{java}#{arch}.dmg"
  name "oXygen XML Editor"
  desc "Tools for XML editing, including Oxygen XML Developer and Author"
  homepage "https://www.oxygenxml.com/xml_editor.html"

  livecheck do
    url "https://www.oxygenxml.com/rssBuildID.xml"
    strategy :page_match do |page|
      version = page.match(/Oxygen\sXML\sEditor\sversion\s(\d+(?:\.\d+)+)/i)
      build = page.match(/build\sid:\s(\d+)/i)
      next if version.blank? || build.blank?

      "#{version[1]},#{build[1]}"
    end
  end
  
  depends_on macos: ">= :el_capitan"
  
  suite "Oxygen XML Editor"
end
