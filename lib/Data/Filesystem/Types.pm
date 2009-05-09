package Data::Filesystem::Types;

use strict;
use MooseX::Types::Moose qw(Str ArrayRef);
use MooseX::Types -declare => [qw/Item File Directory Link Filename Path PathString/];

role_type Item, { role => 'Data::Filesystem::Item' };
class_type File, { class => 'Data::Filesystem::File' };
class_type Directory, { class => 'Data::Filesystem::Directory' };
class_type Link, { class => 'Data::Filesystem::Link' };

subtype Filename, as Str, where { m{^[^/\0]+$} };
subtype Path, as ArrayRef[Filename];

subtype PathString, as Str, where { m{/} }; # needs a /

coerce Path, from PathString, via { [ split m{/}, $_ ] };

1;
