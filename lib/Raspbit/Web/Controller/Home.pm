package Raspbit::Web::Controller::Home;

use Mojo::Base 'Mojolicious::Controller';

sub home 
{
  my $self = shift;

  $self->render(template => 'home');
}

1;
