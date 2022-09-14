/**
 * Solana Account Management Handler
 */
component extends="coldbox.system.RestHandler" secured {

	property name="SolanaAPI" inject="solana@solanacfc";

	include "./helpers/response.cfm";

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
	 * Get the user's account info
	 *
	 * @x           -route (GET) /api/solana/account/info/:publicKey
	 * @requestBody ~solana/account/accountInfo.json
	 * @response    -default ~solana/account/accountInfo.json##200
	 * @response    -401 ~solana/account/accountInfo.json##401
	 */
	function getAccountInfo( event, rc, prc ) {
		try {
			if( !structKeyExists( rc, "publicKey" ) OR !len( trim( rc.publicKey ) ) ) {
				throw "the argument publicKey (target public key) is required";
			}
				
			writeOutput("Received call to getAccountInfo #rc.publicKey#");

			// attempt retrieve the account info from the SolanaAPI
			var responseData = SolanaAPI.getAccountInfo( rc.publicKey );

			// parse the API response
			processSolanaResponse( event.getResponse(), responseData );
		} catch( any except ) {
			writeOutput("Error during call to getAccountInfo #except#");
		}
	}

	/**
	 * Get the user's account balance
	 *
	 * @x           -route (GET) /api/solana/account/balance/:publicKey
	 * @requestBody ~solana/account/accountBalance.json
	 * @response    -default ~solana/account/accountBalance.json##200
	 * @response    -401 ~solana/account/accountBalance.json##401
	 */
	function getBalance( event, rc, prc ) {
		try {
			if( !structKeyExists( rc, "publicKey" ) OR !len( trim( rc.publicKey ) ) ) {
				throw "the argument publicKey (target public key) is required";
			}

			writeOutput("Received call to getBalance #rc.publicKey#");

			// attempt retrieve the account balance from the SolanaAPI
			var responseData = SolanaAPI.getBalance( rc.publicKey );

			// parse the API response
			processSolanaResponse( event.getResponse(), responseData );
		} catch( any except ) {
			writeOutput("Error during call to getBalance #except#");
		}
	}
}