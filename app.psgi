use strict;
use feature ":5.10";
use Cwd qw(abs_path);
use HTML::Mason::Interp;
sub {
    my ($env) = @_;

    my $interp = HTML::Mason::Interp->new(
        comp_root => abs_path("comps/"),
    );

    my $comp_path = "/$env->{PATH_INFO}" =~ s{/$}{/index}r;
    my $body;
    eval { $interp->make_request(comp=>$comp_path,out_method=>\$body)->exec };
    $body = $@->as_html if $@;

    [
        200,
        [ "Content-type", "text/html" ],
        [ $body ],
    ];
};
