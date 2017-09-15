package GraphQL::Type::Union;

use 5.014;
use strict;
use warnings;
use Moo;
use MooX::Thunking;
use Types::Standard -all;
use GraphQL::Type::Library -all;
use Return::Type;
use Function::Parameters;
extends qw(GraphQL::Type);
with qw(
  GraphQL::Role::Output
  GraphQL::Role::Composite
  GraphQL::Role::Abstract
  GraphQL::Role::Nullable
  GraphQL::Role::Named
);

our $VERSION = '0.02';

=head1 NAME

GraphQL::Type::Union - GraphQL union type

=head1 SYNOPSIS

  use GraphQL::Type::Union;
  my $union_type = GraphQL::Type::Union->new(
    name => 'Union',
    types => [ $type1, $type2 ],
    resolve_type => sub {
      return $type1 if ref $_[0] eq 'Type1';
      return $type2 if ref $_[0] eq 'Type2';
    },
  );

=head1 ATTRIBUTES

Inherits C<name>, C<description> from L<GraphQL::Type>.

=head2 types

Thunked array-ref of L<GraphQL::Type::Object> objects.

=cut

has types => (
  is => 'thunked',
  isa => UniqueByProperty['name'] & ArrayRefNonEmpty[InstanceOf['GraphQL::Type::Object']],
  required => 1,
);

=head2 resolve_type

Optional code-ref. Input is a value, returns a GraphQL type object for
it. If not given, relies on its possible type objects having a provided
C<is_type_of>.

=cut

has resolve_type => (is => 'ro', isa => CodeRef);

=head1 METHODS

=head2 get_types

Returns list of L<GraphQL::Type::Object>s of which the object is a union,
performing validation.

=cut

has _types_validated => (is => 'rw', isa => Bool);
method get_types() :ReturnType(ArrayRefNonEmpty[InstanceOf['GraphQL::Type::Object']]) {
  my @types = @{ $self->types };
  return @types if $self->_types_validated; # only do once
  if (!$self->resolve_type) {
    my @bad = map $_->name, grep !$_->is_type_of, @types;
    die $self->name." no resolve_type and no is_type_of for @bad" if @bad;
  }
  $self->_types_validated(1);
  @types;
}

__PACKAGE__->meta->make_immutable();

1;
