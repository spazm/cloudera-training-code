#!/usr/bin/perl

use strict;
use warnings;

package KVTest;
use Moose::Role;
use Data::Dumper;

sub map
{
	my $self = shift;
	my $key = Dumper \@_;
	$self->emit( $key, 1);
}

sub reduce
{
	my ($self, $key, $value_iterator) = @_;
	$self->emit( $key, 1)
		if length $key;
}
no Moose;

package KVTest::Mapper;
use Moose;
with 'KVTest', 'Hadoop::Streaming::Mapper';
no Moose;
__PACKAGE__->meta->make_immutable();

package KVTest::Reducer;
use Moose;
with 'KVTest', 'Hadoop::Streaming::Reducer';
no Moose;
__PACKAGE__->meta->make_immutable();


package main;

if ( !caller() )
{
my $package = !@ARGV  
	? 'KVTest::Mapper'
	: 'KVTest::Reducer'
	;
$package->run();
}
1;
