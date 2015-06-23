package Raspbit::Web;

use Mojo::Base 'Mojolicious';

use Raspbit::Web::Controller::Home;

use Raspbit::Web::Controller::Camera;

# This method will run once at server start
sub startup 
{
	my $self = shift;

	# Template Toolkit plugin configuration
	$self->plugin(tt_renderer => { 
		template_options => { 
			WRAPPER => 'wrapper.tt',
			} 
		});
	$self->renderer->default_handler('tt');

  	# Router
  	my $r = $self->routes;

  	# Normal route to controller
  	$r->get('/')->to('home#home');
	$r->get('/camera')->to('camera#take');
}

1;
