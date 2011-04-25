#!/usr/bin/perl

use strict;
use warnings;

package AverageWordCount;
use Any::Moose 'Role';
use Data::Dumper;

sub map
{
	my ($self,$line) = @_;
	my @words = split(/\W+/, $line);
	foreach my $word (@words)
	{
		my(@letters) = split(//,$word);
		$self->emit( $letters[0] => scalar @letters);
	}
}

sub reduce
{
	my ($self, $key, $value_iterator) = @_;
	my $count = 0;
	my $value = 0;
	while( $value_iterator->has_next() )
	{
		my $length = $value_iterator->next();
		$value += $length;
		$count += 1;
	}
	my $output = sprintf( "%.1f", $value/$count);
	$self->emit( $key, $output);
}
no Any::Moose;

package AverageWordCount::Mapper;
use Any::Moose;
with 'AverageWordCount', 'Hadoop::Streaming::Mapper';
no Any::Moose;
__PACKAGE__->meta->make_immutable();

package AverageWordCount::Reducer;
use Any::Moose;
with 'AverageWordCount', 'Hadoop::Streaming::Reducer';
no Any::Moose;
__PACKAGE__->meta->make_immutable();


package main;

my $package = !@ARGV  
	? 'AverageWordCount::Mapper'
	: 'AverageWordCount::Reducer'
	;
	
$package->run();
