use MooseX::Declare;

class Data::Filesystem::File with Data::Filesystem::Item {
    use MooseX::Types::Moose qw(Str);
    use Data::Filesystem::Types qw(Filename);

    # mostly used when walking the tree from a Directory parent
    method get(Filename $name){
        confess "The file is not named $name"
          unless $name eq $self->name;

        return $self;
    }

    has 'contents' => (
        is         => 'ro',
        isa        => Str,
        lazy_build => 1,
    );

    sub _build_contents {
        return "";
    }

    method size() {
        return length $self->contents;
    }
}

1;
