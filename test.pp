
logstash_input { 'system.log':
   type     => 'system-log',
   provider => 'file',
   path     => '/private/var/log/system.log'
 }