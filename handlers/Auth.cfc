/**
 * Authentication Handler
 */
component extends="coldbox.system.RestHandler" {

	property name="UserService" inject="UserService";

	/**
	 * Login a user into the application
	 *
	 * @x           -route (POST) /api/login
	 * @requestBody ~auth/login/requestBody.json
	 * @response    -default ~auth/login/responses.json##200
	 * @response    -401 ~auth/login/responses.json##401
	 */
	function login( event, rc, prc ){
		param rc.username = "";
		param rc.password = "";

		try {
			var token = jwtAuth().attempt( rc.username, rc.password );

			event.getResponse()
				.setData( token )
				.addMessage(
					"Bearer token created and it expires in #jwtAuth().getSettings().jwt.expiration# minutes"
				);
		} catch ( "InvalidCredentials" e ) {
            event.setHTTPHeader( statusCode = 401, statusText = "Unauthorized" );
            event.getResponse()
				.setData( { "error" : true, "data" : "", "message" : "Invalid Credentials" } );
        }
	}

	/**
	 * Logout a user
	 *
	 * @x        -route (POST) /api/logout
	 * @security bearerAuth,ApiKeyAuth
	 * @response -default ~auth/logout/responses.json##200
	 * @response -500 ~auth/logout/responses.json##500
	 */
	function logout( event, rc, prc ){
		jwtAuth().logout();
		event.getResponse().addMessage( "Successfully logged out" )
	}

}