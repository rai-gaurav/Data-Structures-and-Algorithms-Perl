#!/usr/bin/env perl

# reCAPTCHA is a CAPTCHA system, that is a system that allows web hosts to distinguish between human
# and automated access to websites. More info - https://www.google.com/recaptcha/about/
# You can register your site in google reCAPTCHA at https://www.google.com/recaptcha/admin/create
# You will get 'Site Key' and 'Secret Key'.
# 'Site Key' will be put on front-end side while 'Secret key' will be on server side in environemnt variable.

# https://metacpan.org/pod/Mojolicious
# https://docs.mojolicious.org/Mojolicious/Lite
# https://developers.google.com/recaptcha/docs/v3

# This is a simple Login page. We will be authenticating user.
# After success they will get a home page where we will be welcoming them and they can logout from there.
# In case of authentication failure error will be thrown.

use strict;
use warnings;
use Mojolicious::Lite;
use Mojo::UserAgent;

# Add your 'Secret Key' here
$ENV{'CAPTCHA_V3_SECRET_KEY'} = "";

sub is_valid_captcha {
    my ($c) = @_;

    # https://docs.mojolicious.org/Mojo/Message#json
    my $post_params = $c->req->json;
    my $token       = $post_params->{token};
    my $captcha_url = 'https://www.google.com/recaptcha/api/siteverify';
    my $response
        = $c->ua->post(
        $captcha_url => form => {response => $token, secret => $ENV{'CAPTCHA_V3_SECRET_KEY'}})
        ->result;
    if ($response->is_success()) {
        my $out = $response->json;

        # reCAPTCHA v3 returns a score -> 1.0 is very likely a good interaction, 0.0 is very likely a bot
        if ($out->{success} && $out->{score} > 0.5) {
            return 1;
        }
        else {
            # Its a bot
            return 0;
        }
    }
    else {
        # Connection to reCAPTCHA failed
        return 0;
    }
}

# https://docs.mojolicious.org/Mojolicious/Lite#Helpers
# Check for authentication
helper auth => sub {
    my $c = shift;

    if (($c->param('username') eq 'admin') && ($c->param('password') eq 'admin')) {
        return 1;
    }
    else {
        return 0;
    }
};

helper ua => sub {
    my $ua = Mojo::UserAgent->new;
    $ua->transactor->name('Mozilla/5.0 (Windows NT 6.1; WOW64; rv:77.0) Gecko/20190101 Firefox/77.0');
    return $ua;
};

# Different Routes
get '/' => sub { shift->render } => 'index';

post '/login' => sub {
    my $c = shift;
    if ($c->auth) {
        $c->session(auth => 1);
        $c->flash(username => $c->param('username'));
        return $c->redirect_to('home');
    }
    $c->flash('error' => 'Wrong login/password');
    $c->redirect_to('index');
} => 'login';

post '/recaptchav3-verify' => sub {
    my $c = shift;
    if (is_valid_captcha($c)) {
        return $c->render(json => {error => Mojo::JSON->false});
    }
    else {
        return $c->render(
            json => {error => Mojo::JSON->true, description => 'Captcha verification failed.'});
    }
};

get '/logout' => sub {
    my $c = shift;
    delete $c->session->{auth};
    $c->redirect_to('index');
} => 'logout';

# https://docs.mojolicious.org/Mojolicious/Lite#Under
under sub {
    my $c = shift;
    return 1 if ($c->session('auth') // '') eq '1';

    $c->render('denied');
};

get '/home' => sub {
    my $c = shift;
    $c->render();
} => 'home';

app->start;

__DATA__


@@ index.html.ep
<html>
    <head>
        <script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=<Your Site Key>"></script>
    </head>
    <body>
        %= t h1 => 'Login'

        % if (flash('error')) {
            <h2 style="color:red"><%= flash('error') %></h2>
        % }

        %= form_for login => (method => 'post') => begin
            <label>username:</label> <%= text_field 'username' %>
        <br /><br />
            <label>password:</label> <%= password_field 'password' %>
        <br /><br />
            <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response">
            <input type="hidden" name="action" value="validate_captcha">
        %= submit_button 'Log in', id => 'submit'
        %= end
        <script>
            function onloadCallback() {
                grecaptcha.ready(function() {
                    grecaptcha.execute('<Your Site Key>', {action:'validate_captcha'})
                    .then(function(token) {
                        document.getElementById('g-recaptcha-response').value = token;
                        // Create an endpoint on your server to validate the token and return the score
                        fetch('/recaptchav3-verify', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify({'token': token})
                        })
                        .then(response => response.json())
                        .then(data => {
                            if (data.error === true) {
                                alert(data.description + " Bot found.");
                            }
                            else {
                                console.log('reCaptcha verification : success');
                            }
                        })
                        .catch((error) => {
                            console.error('Error:', error);
                        });
                    });
                });
            }
        </script>
    </body>
</html>


@@ home.html.ep
%= t h1 => 'Home Page'
<h2 style="color:green">Hello <%= flash('username') %></h2>
<a href="<%= url_for('logout') %>">Logout</a>


@@ denied.html.ep
%= t h2 => 'Access Denied'
<a href="<%= url_for('index') %>">Login</a>
