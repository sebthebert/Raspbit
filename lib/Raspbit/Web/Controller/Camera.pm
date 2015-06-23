package Raspbit::Web::Controller::Camera;

use Mojo::Base 'Mojolicious::Controller';
use POSIX qw( strftime );

my $dir_data = ''; 

sub take 
{
  	my $self = shift;

	my $filename = strftime("%Y%m%d_%H%M%S", localtime) . '.jpg';
	`raspistill -o $filename`;

  	$self->render(template => 'home');
}

1;
