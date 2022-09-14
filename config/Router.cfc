/**
 * ContentBox - A Modular Content Platform
 * Copyright since 2012 by Ortus Solutions, Corp
 * www.ortussolutions.com/products/contentbox
 * ---
 * Application Router
 */
component {

	function configure(){
		// Configuration
		setValidExtensions( "xml,json,jsont,rss,html,htm,cfm,print,pdf,doc,txt" );
		// Process Full Rewrites then true, else false and an `index.cfm` will always be included in URLs
		setFullRewrites( true );

		/**
		 * --------------------------------------------------------------------------
		 * App Routes
		 * --------------------------------------------------------------------------
		 *
		 * Here is where you can register the routes for your web application!
		 * Go get Funky!
		 *
		 */

		// Solana API Endpoints
		get( "/api/solana/account/balance/:publicKey", "solana.account.getBalance" );
		get( "/api/solana/account/info/:publicKey", "solana.account.getAccountInfo" );

		post( "/api/solana/transaction/airdrop", "solana.transaction.requestAirdrop" );
		get( "/api/solana/transaction/:signature", "solana.transaction.getTransaction" );

		// Mappings
		route( ":handler/:action" ).end();
	}

}
