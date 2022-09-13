/**
 * User Wallet Management Handler
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
	 * List all wallets for the user
	 *
	 * @x           -route (GET) /api/user/:userId/wallet
	 * @requestBody ~user/wallet/list/requestBody.json
	 * @response    -default ~user/wallet/list/responses.json##200
	 * @response    -401 ~user/wallet/list/responses.json##401
	 */
	function index( event, rc, prc ){

		// default pagination
		event.paramValue( "offset", 0 );
		event.paramValue( "max", 9999 );

		// determine result sort order
		prc.sortOrder = 'createdOn';
		if( event.valueExists( "sort" ) )
			if( listFindNoCase( 'createdOn,modifiedOn', rc.sort ) )
				prc.sortOrder = rc.sort;

		// build filter criteria, defaulting isActive to true
		var userWalletCriteria = ORMService.newCriteria( "UserWallet" )
			.eq( "user.id", javaCast( "int", rc.userId ) )

			.when( event.valueExists( "name" ), function( c ){
				c.joinTo( "wallet", "wallet" )
					.eq( "wallet.name", rc.name ) 
			})

			.when( event.valueExists( "isActive" ) AND isBoolean( rc.isActive ), function( c ){
				c.eq( "isActive", rc.isActive )
			})
			.when( !event.valueExists( "isActive" ) OR !isBoolean( rc.isActive ), function( c ){
				c.eq( "isActive", true )
			});

		// find all of the user wallet records that match the criteria
		prc.userWallets = userWalletCriteria
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
		event.getResponse().setData( prc.UserWallets );

	}

	/**
	 * Create a new user wallet instance
	 *
	 * @x           -route (POST) /api/user/:userId/wallet
	 * @requestBody ~user/wallet/create/requestBody.json
	 * @response    -default ~user/wallet/create/responses.json##200
	 * @response    -401 ~user/wallet/create/responses.json##401
	 */
	function create( event, rc, prc ){

		prc.userWallet = getInstance( "UserWallet" )
					.new({
						userId: rc.userId,
						walletId: rc.walletId,
						setting: rc.setting,
						value: rc.value
					})
					.save();
	
		event.getResponse().setData( prc.userWallet.getMemento() );
	}

	/**
	 * Retrieve a specific user wallet instance by id
	 *
	 * @x           -route (GET) /api/user/:userId/wallet/:id
	 * @requestBody ~user/wallet/get/requestBody.json
	 * @response    -default ~user/wallet/get/responses.json##200
	 * @response    -401 ~user/wallet/get/responses.json##401
	 */
	function show( event, rc, prc ){

		event.paramValue( "id", 0 );
		prc.userWallet = getInstance( "UserWallet" )
						.get( rc.id ?: -1 )
						.getMemento();

		event.getResponse().setData( prc.userWallet );
	}

	/**
	 * Update an existing user wallet instance
	 *
	 * @x           -route (PUT) /api/user/:userId/wallet/:id
	 * @requestBody ~user/wallet/update/requestBody.json
	 * @response    -default ~user/wallet/update/responses.json##200
	 * @response    -401 ~user/wallet/update/responses.json##401
	 */
	function update( event, rc, prc ){
		event.paramValue( "id", 0 );

		prc.userWallet = getInstance( "UserWallet" )
					.getOrFail( rc.id ?: -1 );

		if( event.valueExists( "publicKey" ) )
			prc.userWallet.setPublicKey( rc.publicKey )

		if( event.valueExists( "isActive" ) )					
			prc.userWallet.setIsActive( rc.isActive )

		prc.userWallet.save();
	
		event.getResponse().setData( prc.userWallet.getMemento() );

	}

	/**
	 * Delete an existing user wallet instance
	 *
	 * @x           -route (DELETE) /api/user/:userId/wallet/:id
	 * @requestBody ~user/wallet/delete/requestBody.json
	 * @response    -default ~user/wallet/delete/responses.json##200
	 * @response    -401 ~user/wallet/delete/responses.json##401
	 */
	function delete( event, rc, prc ){
		event.paramValue( "id", 0 );

		prc.user = getInstance( "UserWallet" )
					.getOrFail( rc.id ?: -1 )
					.setIsActive( 0 )
					.save();

	}

}