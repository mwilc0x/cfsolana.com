/**
 * Solana API Service Wrapper
 * 
 * TThis service wrapper leverages the JSON-RPC API from Solana.
 */
component accessors="true" {

	property name="settings" inject="coldbox:moduleSettings:solana";

	/**
	 * --------------------------------------------------------------------------
	 * Methods
	 * --------------------------------------------------------------------------
	 */

	/**
	 * Default object constructor
	 */
	public Solana function init(){
		return this;
	}


	/**
	 * --------------------------------------------------------------------------
	 */

	/**
	 * Returns all information associated with the account of provided public key
	 *
	 * @publicKey the public key value for the account details to retrieve
	 */
	public struct function getAccountInfo( required string publicKey ){

		var response = makeCall( 
				method = "getAccountInfo",
				params = [
					arguments.publicKey,
					{ "encoding": "jsonParsed" }
				]
			);

		return response;

	}


	/**
	 * Returns the balance of the account of provided public key
	 *
	 * @publicKey the public key value for the account to retrieve the balance for
	 */
	public struct function getBalance( required string publicKey ){

		var response = makeCall( 
				method = "getBalance",
				params = [
					arguments.publicKey
				]
			);

		return response;

	}


	/**
	 * Returns transaction details for a confirmed transaction
	 *
	 * @transaction the transaction signature as a base-58 encoded string
	 */
	public struct function getTransaction( required string transaction ){

		var response = makeCall( 
				method = "getTransaction",
				params = [
					arguments.transaction,
					"jsonParsed"
				]
			);

		return response;

	}


	/**
	 * Requests an airdrop of lamports to a public key, returns the transaction identifier
	 *
	 * @publicKey the public key value for the account to send the tokens to
	 * @tokens the number of tokens to send
	 */
	public struct function requestAirdrop( required string publicKey, required numeric tokens ){

		var response = makeCall( 
				method = "requestAirdrop",
				params = [
					arguments.publicKey,
					createObject( "java", "java.math.BigInteger" ).init( javacast( "string", arguments.tokens ) )
				]
			);

		return response;

	}

	/**
	 * --------------------------------------------------------------------------
	 * Private Utility Methods
	 * --------------------------------------------------------------------------
	 */

	/**
	 * Creates and executes an API call
	 *
	 * @url the target API url, falls back to the module settings API_URL value
	 * @method the API method being requested
	 * @params a array request parameter values to pass with the API call
	 */
	private any function makeCall( string url, required string method, array params = [] ){

		var requestURL = ( structKeyExists( arguments, "url" ) ? arguments.url : settings.API_URL );
		
		var requestBody = {
			"jsonrpc": "2.0",
			"id": 1,
			"method": arguments.method,
			"params": arguments.params
		};

		var httpRequest = new http( url = requestURL, method = "POST" );
		httpRequest.addParam( type = "header", name = "Content-Type", value = "application/json" );
		httpRequest.addParam( type = "body", value = "#serializeJSON( requestBody )#" );

		try{

			var httpResponse = httpRequest.send().getPrefix();

			var response = {
				"status" = {
					"code" = listFirst( httpResponse.statusCode, " " ),
					"text" = listLast( httpResponse.statusText, " " )
				},
				"data" = deserializeJSON( httpResponse.filecontent ),
				"error" = httpResponse.errorDetail
			}

		} catch( any except ) {
			var response = {
				"status" = {
					"code" = "500",
					"text" = "Solana API Error"
				},
				"data" = except.detail,
				"error" = except.message
			}
		}

		return response;
	}


}