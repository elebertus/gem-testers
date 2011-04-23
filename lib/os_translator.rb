module OSTranslator
  OSMap = {
    /^[Dd]arwin/   => 'Mac OS X',
    /^[Ll]inux(?:-gnu)?/i => 'Linux',
    /^[Mm]swin/ => 'Windows (Visual C)',
    /^[Mm]ingw/ => 'Windows (mingw)',
    /^[Ff]reebsd/ => 'FreeBSD'
  }

  VersionMap = {
    /^Mac OS X/ => lambda do |x| 
      case x
      when /10.[0-9]+.*/
        x.split('.')[0..1].join('.')
      else
        'Unknown'
      end
    end,
    /^Windows/ => lambda { |x| "#{x}-bit" },
    /^FreeBSD/ => lambda { |x| x.to_s },
    /^Linux/ => lambda { |x| '' }
  }

  def self.translate(os_string)
    os_string = os_string.dup
    OSMap.keys.each do |os|
      if os_string =~ os
        os_string.sub!(os) { |x| OSMap[os] + ' ' }
        VersionMap.keys.each do |version|
          if os_string =~ version
            version_only = os_string.sub(version, '').strip
            if version_only.empty?
              os_string += "Unknown"
            else
              os_string.sub!(/#{Regexp.quote(version_only)}/, VersionMap[version].call(version_only))
            end
            return os_string
          end
        end
      end
    end

    return os_string
  end
end
