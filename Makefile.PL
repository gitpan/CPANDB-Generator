use inc::Module::Install::DSL 0.91;

all_from      lib/CPANDB/Generator.pm
requires_from lib/CPANDB/Generator.pm
requires_from lib/CPANDB/Generator/GetIndex.pm
requires_from script/cpandb-generate
requires      Probe::Perl       0.01
requires      Time::Elapsed     0.26
requires      Xtract::Publish   0.10
requires      ORDB::CPANUploads 0.04
requires      ORDB::CPANMeta    0.01
test_requires Test::More        0.42
test_requires URI::file         4.20
test_requires File::Remove      1.42