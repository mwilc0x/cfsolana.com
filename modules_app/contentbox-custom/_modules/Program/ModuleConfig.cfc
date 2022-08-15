/**
 * ContentBox - A Modular Content Platform
 * Copyright since 2012 by Ortus Solutions, Corp
 * www.ortussolutions.com/products/contentbox
 * ---
 */
component hint="My Module Configuration" {

	// Module Properties
	this.title = "Program Manager";
	this.author = "Ortus Solutions, Corp";
	this.webURL = "https://www.ortussolutions.com";
	this.description = "This module supports all functionality around eco-program management";
	this.version = "1.0";

	this.viewParentLookup = true;
	this.layoutParentLookup = true;

	this.entryPoint = "program";
	this.modelNamespace = "program";
	this.cfmapping = "program";
	this.dependencies = ["program-api-v1"];

	function configure(){
		// parent settings
		parentSettings = {};

		// module settings - stored in modules.name.settings
		settings = {};

		// Layout Settings
		layoutSettings = { 
			defaultLayout : "" 
		};

		// datasources
		datasources = {};

		// web services
		webservices = {};

		// SES Routes
		/*
		routes = [
			// Module Entry Point
			{ pattern : "/", handler : "programs", action : "index" },
			// Convention Route
			{ pattern : "/:handler/:action?" }
		];
		*/

		// Custom Declared Points
		interceptorSettings = { customInterceptionPoints : "" };

		// Custom Declared Interceptors
		interceptors = [];

		// Binder Mappings
		//binder.map( "ProgramService@program" ).to( "#moduleMapping#.models.ProgramService" );
		//binder.mapDirectory( packagePath = "#moduleMapping#/models", namespace = "@program" );

	}

	/**
	 * Fired when the module is registered and activated.
	 */
	function onLoad(){

		// add a menu link to the module
		var menuService = controller.getWireBox().getInstance( "AdminMenuService@contentbox" );
		menuService.addTopMenu( name = "ProgramManager", label = "<i class='fas fa-box-open'></i> Programs" )
			.addSubMenu(
				name = "Manage",
				label = "Manage",
				href = "#menuService.buildModuleLink( "program", "programs.index" )#",
				permissions = "AUTHOR_ADMIN"
			);

	}

	/**
	 * Fired when the module is activated by ContentBox
	 */
	function onActivate(){

		// load the module settings
		var settingService = controller.getWireBox().getInstance("SettingService@contentbox");

		var findArgs = { name = "program" };
		var setting = settingService.findWhere( criteria = findArgs );
		if( isNull( setting ) ){
			var args = { name = "program", value = serializeJSON( settings ) };
			var programSettings = settingService.new( properties = args );
			settingService.save( programSettings );
		}

		// flush the settings cache so our new settings are reflected
		settingService.flushSettingsCache();

	}

	/**
	 * Fired when the module is unregistered and unloaded
	 */
	function onUnload(){

		// remove ourselves from the main menu to clean up
		var menuService = controller.getWireBox().getInstance( "AdminMenuService@contentbox" );
		menuService.removeTopMenu( "ProgramManager" );

	}

	/**
	 * Fired when the module is deactivated by ContentBox
	 */
	function onDeactivate(){

		// remove the module settings
		var settingService = controller.getWireBox().getInstance( "SettingService@contentbox" );
		var args = { name = "program" };
		var setting = settingService.findWhere( criteria = args );
		if( !isNull( setting ) ){
			settingService.delete( setting );
		}
	}

}
