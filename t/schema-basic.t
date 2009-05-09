use strict;
use warnings;
use Test::More tests => 6;

use ok 'Data::Filesystem::File';
use ok 'Data::Filesystem::Directory';

my $root = Data::Filesystem::Directory->new( name => 'root' );
my $foo = Data::Filesystem::File->new(
    parent   => $root,
    name     => 'foo',
    contents => 'foo',
);

my $dir = Data::Filesystem::Directory->new(
    parent => $root,
    name   => 'dir',
);

my $bar = Data::Filesystem::File->new(
    parent   => $dir,
    name     => 'bar',
    contents => 'bar',
);

is_deeply [$root->path], ['root'], 'root has path';
is_deeply [$foo->path], ['root', 'foo'], 'foo has path';
is_deeply [$dir->path], ['root', 'dir'], 'dir has path';
is_deeply [$bar->path], ['root', 'dir', 'bar'], 'bar has path';


