use MooseX::Declare;

role Data::Filesystem::Item {
    use Data::Filesystem::Types qw(Filename Item);

    requires 'get';

    has 'name' => (
        is       => 'ro',
        isa      => Filename,
        required => 1,
    );

    has 'parent' => (
        is        => 'ro',
        isa       => Item, # maybe Directory only?
        predicate => 'has_parent',
        trigger   => sub {
            my ($self, $parent) = @_;
            $parent->add_file($self);
        },
    );

    method path() {
        if($self->has_parent){
            return $self->parent->path, $self->name;
        }
        else {
            return $self->name;
        }
    }

}

1;
