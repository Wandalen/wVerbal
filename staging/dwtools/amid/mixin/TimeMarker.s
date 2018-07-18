( function _TimeMarker_s_() {

'use strict';

var _ = _global_.wTools;
var _hasOwnProperty = Object.hasOwnProperty;

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

/**
 * Mixin time marker.
 * @param {object} dstProto - prototype of another object.
 * @method _mixin
 * @memberof wTimeMarker#
 */

function _mixin( cls )
{

  var dstProto = cls.prototype;

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.routineIs( cls ) );

  _.mixinApply
  ({
    dstProto : dstProto,
    descriptor : Self,
  });

}

//

/**
 * Produce time marker.
 * @param {object} o - o
 * @method timeMarker
 * @memberof wTimeMarker#
 */

function timeMarker( o )
{
  var self = this;
  var logger = self.logger || _global_.logger;

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.strIs( o ) || _.objectIs( o ) );

  if( _.strIs( o ) )
  o = { description : o };

  _.assertMapHasOnly( o, timeMarker.defaults );

  /* */

  if( !o.beginTime )
  {
    o.beginTime = self.usingTiming ? _.timeNow() : null;

    if( self.verbosity )
    {
      logger.logUp( 'Starts ' + o.description + '..' );
    }

    return o;
  }

  /* */

  if( self.usingTiming )
  {
    o.totalTime = _.timeNow() - o.beginTime;
    var spentStr = 'Spent for ' + o.description;
    if( spentStr[ spentStr.length-1 ] !== ' ' )
    spentStr += ' ';
    logger.logDown( _.timeSpent( spentStr, o.beginTime ) );
    delete o.beginTime;
  }
  else if( self.verbosity )
  {
    logger.down();
  }

  return o;
}

timeMarker.defaults =
{
  beginTime : null,
  totalTime : null,
  description : '',
}

// --
// relationships
// --

var Composes =
{
  verbosity : 1,
  usingTiming : true,
}

//

var Supplement =
{

  timeMarker : timeMarker,

  Composes : Composes,

}

//

var Self =
{

  supplement : Supplement,

  _mixin : _mixin,
  name : 'wTimeMarker',
  nameShort : 'TimeMarker',

}

// export

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
_global_[ Self.name ] = _[ Self.nameShort ] = _.mixinMake( Self );

})();
