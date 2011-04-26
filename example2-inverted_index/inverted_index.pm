#!/usr/bin/perl

use strict;
use warnings;

package InvertedIndex;
use Moose::Role;
use Data::Dumper;

sub map
{
	my ($self,$line)   = @_;
	my ($key, $value)  = split (/\t/, $line, 2);
	#my ($name,$offset) = split( /\@/, $key, 2);
	my @words = split(/\W+/, $value);
	foreach my $word (@words)
	{
		$self->emit( $word, $key);
	}
}

sub reduce
{
	my ($self, $key, $value_iterator) = @_;
	my @values = ();
	while( $value_iterator->has_next() )
	{
		my $fileandoffset = $value_iterator->next();
		next unless defined $fileandoffset;
		push @values, $fileandoffset;
	}
	my $output = join(',',@values);
	$self->emit( $key, $output)
		if length $key;
}
no Moose;

package InvertedIndex::Mapper;
use Moose;
with 'InvertedIndex', 'Hadoop::Streaming::Mapper';
no Moose;
__PACKAGE__->meta->make_immutable();

package InvertedIndex::Reducer;
use Moose;
with 'InvertedIndex', 'Hadoop::Streaming::Reducer';
no Moose;
__PACKAGE__->meta->make_immutable();


package main;

if ( !caller() )
{
my $package = !@ARGV  
	? 'InvertedIndex::Mapper'
	: 'InvertedIndex::Reducer'
	;
$package->run();
}
1;
