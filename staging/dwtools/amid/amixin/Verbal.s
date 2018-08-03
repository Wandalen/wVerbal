( function _Verbal_s_() {

'use strict';

/**
  @module Tools/mid/mixin/Verbal - Verbal is small mixin which adds verbosity control to your class. It tracks verbosity changes, reflects any change of verbosity to instance's components, and also clamp verbosity in [ 0 .. 9 ] range. Use it as a companion for a logger, mixing it into logger's carrier.
*/

/**
 * @file Verbal.s.
 */

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

Self.shortName = 'Verbal';

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

  src = _.numberClamp( src, 0, 9 );

  self[ verbositySymbol ] = src;

  if( self.fileProvider )
  self.fileProvider.verbosity = self._verbosityForFileProvider();

  if( self.logger )
  self.logger.verbosity = self._verbosityForLogger();

}

//

function _coloringSet( src )
{
  var self = this;

  _.assert( arguments.length === 1 );
  _.assert( _.boolLike( src ) );

  if( !src )
  debugger;

  if( self.logger )
  {
    self[ coloringSymbol ] = src;
    self.logger.outputGray = src ? 0 : 1;
  }
  else
  {
    self[ coloringSymbol ] = src;
  }

}

//

function _coloringGet()
{
  var self = this;
  if( self.logger )
  return !self.logger.outputGray;
  return self[ coloringSymbol ];
}

//

function _verbosityForFileProvider()
{
  var self = this;
  var less = _.numberClamp( self.verbosity-2, 0, 9 );
  _.assert( arguments.length === 0 );
  return less;
}

//

function _fileProviderSet( src )
{
  var self = this;

  _.assert( arguments.length === 1 );

  if( src )
  src.verbosity = self._verbosityForFileProvider();

  self[ fileProviderSymbol ] = src;

}

//

function _verbosityForLogger()
{
  var self = this;
  _.assert( arguments.length === 0 );
  return self.verbosity;
}

//

function _loggerSet( src )
{
  var self = this;

  _.assert( arguments.length === 1 );

  if( src )
  {
    src.verbosity = self._verbosityForLogger();
    src.outputGray = self.coloring ? 0 :1;
  }

  self[ loggerSymbol ] = src;

}

// --
// vars
// --

var verbositySymbol = Symbol.for( 'verbosity' );
var coloringSymbol = Symbol.for( 'coloring' );
var fileProviderSymbol = Symbol.for( 'fileProvider' );
var loggerSymbol = Symbol.for( 'logger' );

// --
// relations
// --

var Composes =
{
  verbosity : 0,
  coloring : 1,
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
  verbosity : { combining : 'supplement' },
  coloring : { combining : 'supplement' },
  fileProvider : { combining : 'supplement' },
  logger : { combining : 'supplement' },
}

// --
// define class
// --

var Supplement =
{

  _verbositySet : _verbositySet,
  _coloringSet : _coloringSet,
  _coloringGet : _coloringGet,

  _verbosityForFileProvider : _verbosityForFileProvider,
  _fileProviderSet : _fileProviderSet,
  _verbosityForLogger : _verbosityForLogger,
  _loggerSet : _loggerSet,


  //

  /* constructor * : * Self, */
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

_global_[ Self.name ] = _[ Self.shortName ] = Self;

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
delete require.cache[ module.id ];

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
