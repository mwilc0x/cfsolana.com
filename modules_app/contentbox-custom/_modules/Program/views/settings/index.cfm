<cfoutput>
	#renderView( "viewlets/assets" )#

	<div class="row">
		<div class="col-md-12">
			<h1 class="h1">
				<i class="fa fa-list"></i> Global Settings
			</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-md-9">
			<div class="panel panel-default">
				<div class="panel-body">
					#getInstance("MessageBox@cbmessagebox").renderit()#

					<div class="tabbable tabs-left">
						<ul class="nav nav-tabs">
							<li class="active"><a href="##groupA" data-toggle="tab"><i class="fa fa-reorder"></i> Settings A</a></li>
							<li><a href="##groupB" data-toggle="tab"><i class="fa fa-th"></i> Settings B</a></li>
						</ul>

						<div class="tab-content">
							<div class="tab-pane active" id="groupA">
								A settings management form could go here where you would manage global settings for all programs.
							</div>
							<div class="tab-pane" id="groupB">
								A settings management form could go here where you would manage global settings for all programs.

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!--- sidebar --->
		<div class="col-md-3">
			<cfinclude template="../sidebar/actions.cfm" >
			<cfinclude template="../sidebar/help.cfm" >
		</div>
	</div>
</cfoutput>