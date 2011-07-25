package t::lib::My::Shopping;
use Moose;

with qw(XML::Writer::Compiler::AutoPackage);

use Data::Dumper;
use HTML::Element::Library;

use XML::Element;

has 'data' => (
    is      => 'rw',
    trigger => \&maybe_morph
);
has 'writer' => ( is => 'rw', isa => 'XML::Writer' );
has 'string' => ( is => 'rw', isa => 'XML::Writer::String' );

sub _tag_shopping {
    my ($self) = @_;

    my $root = $self->data;

    my $elementdata = $self->DIVE( $root, qw(shopping) );

    my ( $attr, $data ) = $self->EXTRACT($elementdata);
    $self->writer->startTag( shopping => @$attr );

    $self->_tag_shopping_item;
    $self->writer->endTag;
}

sub _tag_shopping_item {
    my ($self) = @_;

    my $root = $self->data;

    my $elementdata = $self->DIVE( $root, qw(shopping item) );

    my ( $attr, $data ) = $self->EXTRACT($elementdata);
    $self->writer->startTag( item => @$attr );

    $self->writer->characters($data);
    $self->writer->endTag;
}

sub xml {
    my ($self) = @_;
    my $method = '_tag_shopping';
    $self->$method;
    $self->writer->end;
    $self;
}

1;
