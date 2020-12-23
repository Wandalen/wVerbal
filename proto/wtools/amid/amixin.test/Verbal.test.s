( function _Verbal_test_s_( )
{

'use strict';

/*
qqq : implement tests for mixin vebal
*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../../wtools/Tools.s' );

  _.include( 'wTesting' );

  require( '../amixin/Verbal.s' );

}

let _ = _global_.wTools;

//

function trivial( test )
{

  test.identical( 1, 1 );

}

//

let Self =
{

  name : 'Tools.mid.mixin.Verbal',
  silencing : 1,
  // verbosity : 1,

  tests :
  {
    trivial,
  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
