name             'datamuncher'
maintainer       'khaitu'
maintainer_email 'fos@khaitu.com'
license          'none'
description      'Quick and dirty data consumer/supplier'
long_description 'Quick and dirty data consumer/supplier'
version          '0.1.0'

depends 'rvm'
depends 'mongodb'

supports 'centos,ubuntu,fedora,debian'

recipe 'datamuncher', 'Installs Datamuncher'
