Puppet::Type.newtype(:logstash_input) do

   desc 'Custom Puppet type to manage logstash input methods'

   ensurable

   newparam(:name, :namevar => true) do
      desc 'Name of the input, just a description (required)'
   end
   
   newparam(:type) do
     desc 'A name used in logstash to tag the input for follow-up filtering'
   end
   
   newparam(:provider) do
     desc 'The input plugin used to retrieve the data'
     
     newvalues(:file)
   end
   
   newparam(:path) do
      desc 'The path to the file to use as an input.  You can use globs here, such as "/var/log/*.log" Paths must be absolute and cannot be relative.'
      validate do |value|
         unless (Puppet.features.posix? and value =~ /^\//) or (Puppet.features.microsoft_windows? and (value =~ /^.:\// or value =~ /^\/\/[^\/]+\/[^\/]+/))
            raise(Puppet::Error, "File paths must be fully qualified, not '#{value}'")
         end
      end
   end

   newparam(:exclude) do
      desc 'Exclusions (matched against the filename, not full path). Globs are valid here, too.'
   end

   newparam(:stat_interval) do
      desc 'How often we stat files to see if they have been modified.'
   end

   newparam(:discover_interval) do
      desc 'How often we expand globs to discover new files to watch.'
   end

   newparam(:sincedb_path) do
      desc 'Where to write the since database (keeps track of the current position of monitored log files).'
   end

   validate do
    notice('foo')
   	  unless self[:name] and self[:type] and self[:provider]
   	     raise(Puppet::Error, "Name, type and path are required attributes")
   	  end
   end
end