use strict;
use warnings;

use if !eval{ require Data::Printer },
	'Test::More', skip_all => 'need Data::Printer';

use Test::More;

use Data::Printer colored => 0;
use MooX::Struct Something => [qw( $foo bar )];

my $obj = Something->new(foo => 1, bar => 2);
my $str = p $obj;

is($str, 'Something[ 1, 2 ]');

my $ob2 = Something->new(foo => "Hello\nWorld", bar => ["A","B\nC","D"]);
my $st2 = p $ob2;
like("$st2\n", qr{^Something\[\n}s, 'dump including line breaks');

my $ext = Something->EXTEND('$baz')->new([1, 2, 3]);
my $pxt = p $ext;

is($pxt, 'Something[ 1, 2, 3 ]');

my $bas = MooX::Struct->new;
my $pas = p $bas;

is($pas, 'struct[  ]');

done_testing;
