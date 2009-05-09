use MooseX::Declare;

class Data::Filesystem::Directory with Data::Filesystem::Item {
    use MooseX::MultiMethods;
    use Data::Filesystem::Types qw(Item Filename Path);
    use MooseX::Types::Moose qw(HashRef ArrayRef);
    use MooseX::AttributeHelpers;

    has 'files' => (
        metaclass  => 'Collection::Hash',
        is         => 'ro',
        isa        => HashRef[Item],
        required   => 1,
        lazy_build => 1,
        provides   => {
            exists => '_file_exists',
            set    => '_add_file',
            get    => '_get_file',
            keys   => 'list_filenames',
            values => 'get_all_files',
        },
    );

    method _build_files {
        return +{}; # the base case is boring, but subclasses can be more interesting
    }

    method add_file(Item $item){
        $self->_add_file($item->name, $item);
    }

    multi method get(Filename $name){
        confess "No item named $name in ". (join '/', $self->path)
          unless $self->_file_exists($name);

        return $self->_get_file($name);
    }

    multi method get(Path $path){
        my ($first, @rest) = @$path;

        if(!@rest){
            return $self->get($first);
        }
        else {
            my $dir = $self->get($first);
            return $dir->get([@rest]);
        }
    }

}
