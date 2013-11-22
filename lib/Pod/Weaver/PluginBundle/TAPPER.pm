use strict;
use warnings;

package Pod::Weaver::PluginBundle::TAPPER;
# ABSTRACT: Document your modules like TAPPER does


use Pod::Weaver::Config::Assembler;

sub _exp { Pod::Weaver::Config::Assembler->expand_package($_[0]) }

use namespace::clean;

=head1 DESCRIPTION

This is the L<Pod::Weaver> config I use for building my
documentation. I use it via L<Dist::Zilla::PluginBundle::TAPPER>.

=head1 SYNOPSIS

In weaver.ini:

  [@TAPPER]

or in dist.ini:

  [PodWeaver]
  config_plugin = @TAPPER

=head1 OVERVIEW

This plugin bundle is equivalent to the following weaver.ini file:

  [@CorePrep]

  [Name]

  [Region / prelude]

  [Generic / SYNOPSIS]
  [Generic / DESCRIPTION]
  [Generic / OVERVIEW]

  [Collect / ATTRIBUTES]
  command = attr

  [Collect / METHODS]
  command = method

  [Collect / FUNCTIONS]
  command = func

  [Leftovers]

  [Region / postlude]

  [Authors]
  [Legal]

  [-Transformer]
  transformer = List

  [-SingleEncoding]

=begin Pod::Coverage

mvp_bundle_config

=end Pod::Coverage

=cut

sub mvp_bundle_config {
    return (
        [ '@TAPPER/CorePrep',  _exp('@CorePrep'),    {} ],
        [ '@TAPPER/Name',      _exp('Name'),         {} ],
        [ '@TAPPER/prelude',   _exp('Region'),       { region_name => 'prelude' } ],

        [ 'SYNOPSIS',          _exp('Generic'),      {} ],
        [ 'DESCRIPTION',       _exp('Generic'),      {} ],
        [ 'OVERVIEW',          _exp('Generic'),      {} ],

        [ 'ATTRIBUTES',        _exp('Collect'),      { command => 'attr'   } ],
        [ 'METHODS',           _exp('Collect'),      { command => 'method' } ],
        [ 'FUNCTIONS',         _exp('Collect'),      { command => 'func'   } ],
        [ 'TYPES',             _exp('Collect'),      { command => 'type'   } ],

        [ '@TAPPER/Leftovers', _exp('Leftovers'),    {} ],

        [ '@TAPPER/postlude',  _exp('Region'),       { region_name => 'postlude' } ],

        [ '@TAPPER/Authors',   _exp('Authors'),      {} ],
        [ '@TAPPER/Legal',     _exp('Legal'),        {} ],

        [ '@TAPPER/List',      _exp('-Transformer'), { transformer => 'List' } ],
        [ '@TAPPER/SingleEncoding',  _exp('-SingleEncoding'),               {} ],
    );
}

1;
