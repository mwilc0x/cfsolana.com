/**
 * User Management Handler
 */
component extends="coldbox.system.RestHandler" secured {

	property name="UserService" inject="UserService";

	// HTTP Method Security
	this.allowedMethods = {
		index = "GET",
		create = "POST",
		show = "GET",
		update = "PUT,PATCH",
		delete = "DELETE"
	};

	/**
	 * Param incoming format, defaults to `json`
	 */
	function preHandler( event, rc, prc ){
		event.paramValue( "format", "json" );
	}

	/**
	 * --------------------------------------------------------------------------
	 * API Methods
	 * --------------------------------------------------------------------------
	 */


	/**
	 * List all users
	 *
	 * @x           -route (GET) /api/user
	 * @requestBody ~user/list/requestBody.json
	 * @response    -default ~user/list/responses.json##200
	 * @response    -401 ~user/list/responses.json##401
	 */
	function index( event, rc, prc ){

		// build filter criteria
		prc.criteria = {};
		if( event.valueExists( "username" ) )
			prc.criteria.username = rc.username;
		if( event.valueExists( "email" ) )
			prc.criteria.email = rc.email;

		// determine result sort order
		prc.sortOrder = 'lastName,firstName';
		if( event.valueExists( "sort" ) )
			if( listFindNoCase( 'username,lastname,firstname,lastlogin', rc.sort ) )
				prc.sortOrder = rc.sort;

		// get the results as an array of objects
		prc.users = getInstance( "User" )
						.list( criteria = prc.criteria, sortOrder = prc.sortOrder, asQuery = false )
						.map( function( item ){
							return item.getMemento( includes = "id" );
						} );

		event.getResponse().setData( prc.users );
	}

	/**
	 * Create a new user instance
	 *
	 * @x           -route (POST) /api/user
	 * @requestBody ~user/create/requestBody.json
	 * @response    -default ~user/create/responses.json##200
	 * @response    -401 ~user/create/responses.json##401
	 */
	function create( event, rc, prc ){

		prc.user = getInstance( "User" )
					.new({
						firstName: rc.firstName,
						lastName: rc.lastName,
						username: rc.username,
						expdate: dateAdd( "d", now(), 365 ),
						hits: 0,
						lastlogin: createDate( 2020, 1, 1 ),
						email: rc.email,
						accessLevel: 1,
						bsize: 1.0
					})
					.save();
	
		event.getResponse().setData( prc.user.getMemento() );
	}

	/**
	 * Retrieve a specific user instance by id
	 *
	 * @x           -route (GET) /api/user/:id
	 * @requestBody ~user/get/requestBody.json
	 * @response    -default ~user/get/responses.json##200
	 * @response    -401 ~user/get/responses.json##401
	 */
	function show( event, rc, prc ){

		event.paramValue( "id", 0 );
		prc.user = getInstance( "User" )
						.get( rc.id ?: -1 )
						.getMemento();

		event.getResponse().setData( prc.user );
	}

	/**
	 * Update an existing user instance
	 *
	 * @x           -route (PUT) /api/user/:id
	 * @requestBody ~user/update/requestBody.json
	 * @response    -default ~user/update/responses.json##200
	 * @response    -401 ~user/update/responses.json##401
	 */
	function update( event, rc, prc ){
		event.paramValue( "id", 0 );

		prc.user = getInstance( "User" )
					.getOrFail( rc.id ?: -1 );

		if( event.valueExists( "firstName" ) )					
			prc.user.setFirstName( rc.firstName )

		if( event.valueExists( "lastName" ) )					
			prc.user.setLastName( rc.lastName )
				
		if( event.valueExists( "username" ) )					
			prc.user.setUsername( rc.username )

		if( event.valueExists( "email" ) )					
			prc.user.setEmail( rc.email )

		if( event.valueExists( "expdate" ) )					
			prc.user.setExpDate( rc.expdate )

		if( event.valueExists( "hits" ) )					
			prc.user.setHits( rc.hits )

		if( event.valueExists( "lastlogin" ) )					
			prc.user.setLastLogin( rc.lastlogin )

		if( event.valueExists( "accesslevel" ) )					
			prc.user.setAccessLevel( rc.accesslevel )

		if( event.valueExists( "isActive" ) )					
			prc.user.setIsActive( rc.isActive )

		prc.user.save();
	
		event.getResponse().setData( prc.user.getMemento() );

	}

	/**
	 * Delete an existing user instance
	 *
	 * @x           -route (DELETE) /api/user/:id
	 * @requestBody ~user/delete/requestBody.json
	 * @response    -default ~user/delete/responses.json##200
	 * @response    -401 ~user/delete/responses.json##401
	 */
	function delete( event, rc, prc ){
		event.paramValue( "id", 0 );

		prc.user = getInstance( "User" )
					.getOrFail( rc.id ?: -1 )
					.setIsActive( 0 )
					.save();

	}

}