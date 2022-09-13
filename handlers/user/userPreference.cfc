/**
 * User Preference Management Handler
 */
component extends="coldbox.system.RestHandler" secured {

	property name="ORMService" inject="entityService";

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
	 * List all preferences for the user
	 *
	 * @x           -route (GET) /api/user/:userId/preference
	 * @requestBody ~user/preference/list/requestBody.json
	 * @response    -default ~user/preference/list/responses.json##200
	 * @response    -401 ~user/preference/list/responses.json##401
	 */
	function index( event, rc, prc ){

		// default pagination
		event.paramValue( "offset", 0 );
		event.paramValue( "max", 9999 );

		// determine result sort order
		prc.sortOrder = 'setting,createdOn';
		if( event.valueExists( "sort" ) )
			if( listFindNoCase( 'setting,createdOn,modifiedOn', rc.sort ) )
				prc.sortOrder = rc.sort;

		// build filter criteria, defaulting isActive to true
		var userPreferenceCriteria = ORMService.newCriteria( "UserPreference" )
			.eq( "user.id", javaCast( "int", rc.userId ) )

			.when( event.valueExists( "setting" ), function( c ){
				c.eq( "setting", rc.name ) 
			})

			.when( event.valueExists( "isActive" ) AND isBoolean( rc.isActive ), function( c ){
				c.eq( "isActive", rc.isActive )
			})
			.when( !event.valueExists( "isActive" ) OR !isBoolean( rc.isActive ), function( c ){
				c.eq( "isActive", true )
			});

		// find all of the user preference records that match the criteria
		prc.userPreferences = userPreferenceCriteria
							.list( 
								offset: rc.offset,
								max: rc.max,
								sortOrder: prc.sortOrder,
								asQuery: false
							)
							.map( function( item ){
								return item.getMemento();
							});

		// return
		event.getResponse().setData( prc.userPreferences );

	}

	/**
	 * Create a new user preference instance
	 *
	 * @x           -route (POST) /api/user/:userId/preference
	 * @requestBody ~user/preference/create/requestBody.json
	 * @response    -default ~user/preference/create/responses.json##200
	 * @response    -401 ~user/preference/create/responses.json##401
	 */
	function create( event, rc, prc ){

		prc.userPreference = getInstance( "UserPreference" )
					.new({
						userId: rc.userId,
						setting: rc.setting,
						value: rc.value
					})
					.save();
	
		event.getResponse().setData( prc.userPreference.getMemento( includes="id" ) );
	}

	/**
	 * Retrieve a specific user preference instance by id
	 *
	 * @x           -route (GET) /api/user/:userId/preference/:id
	 * @requestBody ~user/preference/get/requestBody.json
	 * @response    -default ~user/preference/get/responses.json##200
	 * @response    -401 ~user/preference/get/responses.json##401
	 */
	function show( event, rc, prc ){

		event.paramValue( "id", 0 );
		prc.userPreference = getInstance( "UserPreference" )
						.get( rc.id ?: -1 )
						.getMemento();

		event.getResponse().setData( prc.userPreference );
	}

	/**
	 * Update an existing user instance
	 *
	 * @x           -route (PUT) /api/user/:userId/preference/:id
	 * @requestBody ~user/preference/update/requestBody.json
	 * @response    -default ~user/preference/update/responses.json##200
	 * @response    -401 ~user/preference/update/responses.json##401
	 */
	function update( event, rc, prc ){
		event.paramValue( "id", 0 );

		prc.userPreference = getInstance( "UserPreference" )
					.getOrFail( rc.id ?: -1 );

		if( event.valueExists( "setting" ) )
			prc.userPreference.setSetting( rc.setting )
				
		if( event.valueExists( "value" ) )					
			prc.userPreference.setValue( rc.value )

		if( event.valueExists( "isActive" ) )					
			prc.userPreference.setIsActive( rc.isActive )

		prc.userPreference.save();
	
		event.getResponse().setData( prc.userPreference.getMemento() );

	}

	/**
	 * Delete an existing user preference instance
	 *
	 * @x           -route (DELETE) /api/user/:userId/preference/:id
	 * @requestBody ~user/preference/delete/requestBody.json
	 * @response    -default ~user/preference/delete/responses.json##200
	 * @response    -401 ~user/preference/delete/responses.json##401
	 */
	function delete( event, rc, prc ){
		event.paramValue( "id", 0 );

		prc.user = getInstance( "UserPreference" )
					.getOrFail( rc.id ?: -1 )
					.setIsActive( 0 )
					.save();

	}

}