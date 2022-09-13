/**
 * Solana Transaction Management Handler
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
	 * Get the details of a specific transaction
	 *
	 * @x           -route (GET) /api/solana/transaction/:signature
	 * @requestBody ~solana/transaction/transaction.json
	 * @response    -default ~solana/transaction/transaction.json##200
	 * @response    -401 ~solana/transaction/transaction.json##401
	 */
	function getTransaction( event, rc, prc ){

		// verify required arguments
		if( !structKeyExists( rc, "signature" ) OR !len( trim( rc.signature ) ) )
			throw "the argument signature (transaction signature) is required";

		// attempt retrieve the transaction details from the SolanaAPI
		var responseData = SolanaAPI.getTransaction( rc.signature );

		// Solana returns a 200 response, but an empty data collection if the transaction was not found
		if( structKeyExists( responseData, "data" ) && isNull( responseData.data.result ) ){
			responseData.status.text = ( responseData.status.code != "200" ? responseData.status.text : "Transaction Not Found" );
			responseData.status.code = ( responseData.status.code != "200" ? responseData.status.code : "404" );
		}

		// parse the API response
		processSolanaResponse( event.getResponse(), responseData );

	}

	/**
	 * Requests an airdrop of lamports to a public key
	 *
	 * @x           -route (POST) /api/solana/transaction/airdrop
	 * @requestBody ~solana/transaction/airdrop.json
	 * @response    -default ~solana/transaction/airdrop.json##200
	 * @response    -401 ~solana/transaction/airdrop.json##401
	 */
	function requestAirdrop( event, rc, prc ){

		// verify required arguments
		if( !structKeyExists( rc, "publicKey" ) OR !len( trim( rc.publicKey ) ) )
			throw "the argument publicKey (target public key) is required";
		if( !structKeyExists( rc, "tokens" ) )
			throw "the argument tokens (number of tokens to airdrop) is required";
		else if( !isNumeric( rc.tokens ) OR rc.tokens LTE 0 )
			throw "the argument tokens (number of tokens to airdrop) must be greater than 0";

		// attempt retrieve the airdrop the requested tokens using the SolanaAPI
		var responseData = SolanaAPI.requestAirdrop( rc.publicKey, rc.tokens );

		// Solana returns a 200 response, but an empty data collection if the transaction was not found
		if( structKeyExists( responseData, "data" ) && isNull( responseData.data.result ) ){
			responseData.status.text = ( responseData.status.code != "200" ? responseData.status.text : "Transaction Not Found" );
			responseData.status.code = ( responseData.status.code != "200" ? responseData.status.code : "404" );
		}

		// parse the API response
		processSolanaResponse( event.getResponse(), responseData );

	}

	

}