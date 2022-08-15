<cfoutput>
	#renderView( "viewlets/assets" )#
	<div class="row">
		<div class="col-md-12">
			<h1 class="h1">
				<i class="fa fa-file-text-o"></i>
				<cfif prc.program.isLoaded()>Editing "#prc.program.getName()#"<cfelse>Create Program</cfif>
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
							<li class="active"><a href="##programDetails" data-toggle="tab"><i class="fa fa-list"></i> Program Details</a></li>
							<cfif prc.program.isLoaded()>
								<li><!---<a href="##formFields" data-toggle="tab"><i class="fa fa-list"></i> Form Fields</a>---></li>
							</cfif>
						</ul>

						<div class="tab-content">
							<div class="tab-pane active" id="formDetails">
								<!--- Program Details --->
								#html.startForm( name = "programForm", action = prc.xehProgramSave, novalidate = "novalidate" )#
									#html.startFieldset( legend = "Program Details" )#
										#html.hiddenField( name = "programID", bind = prc.program )#

										<!--- Fields --->
										<div class="form-group">
											#html.textField( name = "name", bind = prc.program, label = "Name:", required = "required", class = "form-control", title = "A friendly name for your program" )#
										</div>
										<div class="form-group">
											#html.textarea( name = "description", bind = prc.program, rows = "10", label = "Description:", class = "form-control", title = "A friendly description for your program" )#
										</div>

										<div class="form-actions">
											<button class="btn" onclick="return to('#event.buildLink(prc.xehPrograms)#')">Cancel</button>
											<input type="submit" value="Save" class="btn btn-danger">
										</div>
									#html.endFieldSet()#
								#html.endForm()#
							</div>

							<!--- Form Fields --->
							<!---
							<div class="tab-pane" id="formFields">
								#html.startFieldset(legend="Form Fields")#
									#prc.fieldsViewlet#
								#html.endFieldSet()#
							</div>
							--->
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