Puppet::Type.type(:logstash_input).provide(:file) do
   def exists?
      expected_string = synthesize_snippet
      if File.file?('/etc/logstash/inputs.d/' + resource[:name])
         existing_string = retrieve_snippet
         if existing_string == expected_string
         	return true
         end
      end

      return false
   end

   def create
      file = Puppet::Resource.new(:file, "File[/etc/logstash/inputs.d/]", :parameters => {:contents => synthesize_snippet}
      Puppet::Face[:resource, :current].save file 
   end

   def destroy
     file = Puppet::Resource.new(:file, "File[/etc/logstash/inputs.d/]", :parameters => {:ensure => 'absent'}
     Puppet::Face[:resource, :current].save file
   end

   private
   def synthesize_snippet
      config_string = "file {\n"

      config_string.concat('type => ' + resource[:type] + "\n")
      config_string.concat('path => ' + resource[:path] + "\n")

      if resource[:exclude]
      	 config_string.concat('exclude => ' + resource[:exclude] + "\n")
      end

      if resource[:stat_interval]
      	 confg_string.concat('stat_interval => ' + resource[:stat_interval] + "\n")
      end

      if resource[:discover_interval]
      	 config_string.concat('discover_interval => ' + resource[:discover_interval] + "\n")
      end

      if resource[:sincedb_path]
      	 config_string.concat('sincedb_path => ' + resource[:sincedb_path] + "\n")
      end

      config_string.concat("}\n")

      return config_string
   end

   def retrieve_snippet
      @lines ||= File.readlines('/etc/logstash/inputs.d/' + resource[:name])
   end
end