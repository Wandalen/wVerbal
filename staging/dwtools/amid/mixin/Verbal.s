( function _Verbal_s_() {

'use strict';

debugger;

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  var _ = _global_.wTools;

  _.include( 'wProto' );

}

//

var _global = _global_;
var _ = _global_.wTools;
var Parent = null;
var Self = function wVerbal( o )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  if( !( this instanceof Self ) )
  if( o instanceof Self )
  return o;
  else
  return new( _.routineJoin( Self, Self, arguments ) );
  return Self.prototype.init.apply( this,arguments );
}

Self.nameShort = 'Verbal';

// --
// routines
// --

function _verbositySet( src )
{
  var self = this;

  if( _.boolIs( src ) )
  src = src ? 1 : 0;

  _.assert( arguments.length === 1 );
  _.assert( _.numberIs( src ) );

  if( src < 0 )
  src = 0;
  if( src > 9 )
  src = 9;

  self[ verbositySymbol ] = src;

  if( self.fileProvider )
  self.fileProvider.verbosity = src;
  if( self.logger )
  self.logger.verbosity = src;

}

//

function _fileProviderSet( src )
{
  var self = this;

  _.assert( arguments.length === 1 );

  if( src )
  src.verbosity = self.verbosity;

  self[ fileProviderSymbol ] = src;

}

//

function _loggerSet( src )
{
  var self = this;

  _.assert( arguments.length === 1 );

  if( src )
  src.verbosity = self.verbosity;

  self[ loggerSymbol ] = src;

}

// --
// vars
// --

var verbositySymbol = Symbol.for( 'verbosity' );
var fileProviderSymbol = Symbol.for( 'fileProvider' );
var loggerSymbol = Symbol.for( 'logger' );

// --
// relationships
// --

var Composes =
{
  verbosity : 0,
}

var Aggregates =
{
}

var Associates =
{
}

var Restricts =
{
}

var Statics =
{
}

var Forbids =
{
}

var Accessors =
{
  verbosity : 'verbosity',
  fileProvider : 'fileProvider',
  logger : 'logger',
}

// --
// define class
// --

var Supplement =
{

  _verbositySet : _verbositySet,
  _fileProviderSet : _fileProviderSet,
  _loggerSet : _loggerSet,

  //

  constructor : Self,
  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,
  Accessors : Accessors,

}

//

_.classMake
({
  cls : Self,
  parent : Parent,
  supplement : Supplement,
  withMixin : true,
  withClass : true,
});

// --
// export
// --

_global_[ Self.name ] = _[ Self.nameShort ] = Self;

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
delete require.cache[ module.id ];

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
