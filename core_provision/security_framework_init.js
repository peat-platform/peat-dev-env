/**
 * Created by dconway on 12/03/15.
 */


var couchbase  = require('couchbase');

cluster = new couchbase.Cluster( 'couchbase://localhost' );

db = cluster.openBucket('dbkeys');


var create = function() { 
	db.insert('dbkeys_29f81fe0-3097-4e39-975f-50c4bf8698c7',
   	{ "dbs": [ "users", "clients", "authorizations", "queries" ] },
   	{}, function (err, result) {
   		console.log('Success: ', 'Document Created.')
   		process.exit(code=0)
	});
}

create();
