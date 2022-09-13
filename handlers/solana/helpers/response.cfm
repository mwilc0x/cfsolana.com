<cfscript>

/**
 * Helper function to parse Solana API response into a ColdBox response object
 *
 * response 	the ColdBox response object to populate (passed by reference)
 * responseData the Solana API request response data
 */
private function processSolanaResponse( required response response, required struct responseData ){

try{
	if( isStruct( arguments.responseData ) ){
		if( structKeyExists( arguments.responseData, "error" ) && len( trim( arguments.responseData.error ) ) ){
			arguments.response.setStatusCode( ( arguments.responseData.status.code != "200" ? arguments.responseData.status.code : "500" ) );
			arguments.response.setStatusText( ( arguments.responseData.status.code != "200" ? arguments.responseData.status.text : "Solana API Error" ) );
			arguments.response.setData( arguments.responseData.error );
		}
		else if( structKeyExists( arguments.responseData, "data" ) && isNull( arguments.responseData.data.result ) ){
			arguments.response.setStatusCode( ( arguments.responseData.status.code != "200" ? arguments.responseData.status.code : "500" ) );
			arguments.response.setStatusText( ( arguments.responseData.status.code != "200" ? arguments.responseData.status.text : "Solana API Error" ) );
			arguments.response.setData( {} );
		}
		else {
			arguments.response.setStatusCode( arguments.responseData.status.code );
			arguments.response.setStatusText( arguments.responseData.status.text );
			arguments.response.setData( arguments.responseData.data.result );
		}
	} else {
		arguments.response.setStatusCode( "500" );
		arguments.response.setStatusText( "Solana API Error" );
		arguments.response.setData( arguments.responseData );
	}

} catch( any except ){
	writeDump( arguments.responseData );
	writeDump( except );
	abort;
}

}

</cfscript>