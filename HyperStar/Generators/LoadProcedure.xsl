<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hs="urn:HyperStarExtensions">
	<!--global variables-->
	<xsl:variable name="ResetDimensions" select="/Project/Settings/ResetDimensions"/>
	<xsl:variable name="StartDate" select="/Project/Settings/StartDate"/>
	<xsl:variable name="EndDate" select="/Project/Settings/EndDate"/>
	<xsl:variable name="Active" select="/Project/Settings/Active"/>
	<xsl:variable name="UnknownKey" select="/Project/Settings/UnknownKey"/>
	<xsl:variable name="Subject" select="/Project/Subject"/>
	<xsl:variable name="LoadProcedureNameTemplate" select="/Project/Settings/LoadProcedureNameTemplate"/>
	<xsl:variable name="StepPreSQL" select="/Project/Settings/StepPreSQL"/>
	<xsl:variable name="StepPostSQL" select="/Project/Settings/StepPostSQL"/>
	<xsl:variable name="DimSuffix" select="/Project/Settings/Other/Setting[@name='DimSuffix']/@value"/>
	<!--<xsl:variable name="StagingArea" select="/Project/Settings/StagingArea"/>-->

	<xsl:template match="/Project">
		<!--generate create scripts for each load procedure-->
		<xsl:element name="Output">
			<xsl:choose>
				<xsl:when test="/Project/Settings/Other/Setting[@name='OneFile']/@value='true'">
					<!--create in one file-->
					<xsl:element name="OutputFile">
						<xsl:attribute name="name">
							<xsl:text>create Load Procedures</xsl:text>
							<xsl:text>.sql</xsl:text>
						</xsl:attribute>

						<!--use command-->
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>/*********************************************************/</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>go</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>use&#09;</xsl:text>
						<xsl:value-of select="/Project/Settings/Other/Setting[@name='CoreDatabase']/@value"/>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>go</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>/*********************************************************/</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<!--use command-->


						<!--generate create scripts for each load procedure-->
						<xsl:for-each select="Mappings/Mapping">

							<!--break out this procedure-->
							<xsl:text>&#13;&#10;</xsl:text>
							<xsl:text>/*********************************************************</xsl:text>
							<xsl:text>&#13;&#10;</xsl:text>
							<xsl:value-of select="@name"/><xsl:text> Mapping Load Procedure</xsl:text>
							<xsl:text>&#13;&#10;</xsl:text>
							<xsl:text>*********************************************************/</xsl:text>
							<xsl:text>&#13;&#10;</xsl:text>
							<xsl:text>go</xsl:text>
							<!--use command-->



							<!--create procedures-->
							<xsl:choose>
								<xsl:when test="@type='Static'">
									<xsl:call-template name="LoadStatic" >
										<xsl:with-param name="ProcedureOperation" select="'create'"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="@type='Changing'">
									<xsl:call-template name="LoadChanging" >
										<xsl:with-param name="ProcedureOperation" select="'create'"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="@type='Incremental'">
									<xsl:call-template name="LoadIncremental" >
										<xsl:with-param name="ProcedureOperation" select="'create'"/>
									</xsl:call-template>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>

						<!--break out this procedure-->
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>/*********************************************************</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>Load-All Mapping Load Procedure</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>*********************************************************/</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>go</xsl:text>
						<!--use command-->

						<xsl:call-template name="LoadAll" />

						<!--break out this procedure-->
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>/*********************************************************</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>Clear-All Mapping Load Procedure</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>*********************************************************/</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>go</xsl:text>
						<!--use command-->

						<xsl:call-template name="ClearAll" />

					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<!--create in seperate files-->
					<!--generate create scripts for each load procedure-->
					<xsl:for-each select="Mappings/Mapping">
						<!--create procedure-->
						<xsl:element name="OutputFile">
							<xsl:attribute name="name">
								<xsl:text>create </xsl:text>
								<xsl:call-template name="NameTemplate">
									<xsl:with-param name="Name" select="$LoadProcedureNameTemplate"/>
								</xsl:call-template>
								<xsl:text>.sql</xsl:text>
							</xsl:attribute>

							<!--use command-->
							<xsl:text>/*********************************************************/</xsl:text>
							<xsl:text>&#13;&#10;</xsl:text>
							<xsl:text>use&#09;</xsl:text>
							<xsl:value-of select="/Project/Settings/Other/Setting[@name='CoreDatabase']/@value"/>
							<xsl:text>&#13;&#10;</xsl:text>
							<xsl:text>go</xsl:text>
							<xsl:text>&#13;&#10;</xsl:text>
							<xsl:text>/*********************************************************/</xsl:text>
							<xsl:text>&#13;&#10;</xsl:text>
							<!--use command-->


							<xsl:choose>
								<xsl:when test="@type='Static'">
									<xsl:call-template name="LoadStatic" >
										<xsl:with-param name="ProcedureOperation" select="'create'"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="@type='Changing'">
									<xsl:call-template name="LoadChanging" >
										<xsl:with-param name="ProcedureOperation" select="'create'"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="@type='Incremental'">
									<xsl:call-template name="LoadIncremental" >
										<xsl:with-param name="ProcedureOperation" select="'create'"/>
									</xsl:call-template>
								</xsl:when>
							</xsl:choose>
						</xsl:element>
					</xsl:for-each>
					<xsl:element name="OutputFile">
						<xsl:attribute name="name">
							<xsl:text>create LoadAll</xsl:text>
							<xsl:text>.sql</xsl:text>
						</xsl:attribute>

						<!--use command-->
						<xsl:text>/*********************************************************/</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>use&#09;</xsl:text>
						<xsl:value-of select="/Project/Settings/Other/Setting[@name='CoreDatabase']/@value"/>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>go</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>/*********************************************************/</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<!--use command-->


						<xsl:call-template name="LoadAll" />
					</xsl:element>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<!--display a column name intelligently
	if it contains a period (ie in a function) , don't show the source name
	if it doesn't then show it - add brackets around it as appropriate
	and other things
	-->
	<xsl:template name="DWColumnList">
		<xsl:param name="CreateAt" select="'Stage'"/>
		<xsl:param name="delimiter" select="','"/>
		<xsl:for-each select="/Project/Settings/DWColumns/DWColumn[contains($CreateAt,@createat)]">
			<xsl:value-of select="@name"/>
			<xsl:if test="position() &lt; count(../DWColumn[contains($CreateAt,@createat)])">
				<xsl:value-of select="$delimiter"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="DWInsertColumnList">
		<xsl:param name="Scope" select="'Core'"/>
		<xsl:param name="CreateAt" select="'Stage'"/>
		<xsl:param name="delimiter" select="','"/>
		<xsl:for-each select="/Project/Settings/DWColumns/DWColumn[contains($CreateAt,@createat) and (string-length(@insert) &gt; 0 or (@createat != 'Core' and $Scope='Core')) ]">
			<xsl:value-of select="@name"/>
			<xsl:if test="position() &lt; count(../DWColumn[contains($CreateAt,@createat) and (string-length(@insert) &gt; 0 or (@createat != 'Core' and $Scope='Core'))])">
				<xsl:value-of select="$delimiter"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="DWUpdateList">
		<xsl:param name="CreateAt" select="'Stage'"/>
		<xsl:param name="delimiter" select="','"/>
		<xsl:for-each select="/Project/Settings/DWColumns/DWColumn[contains($CreateAt,@createat) and string-length(@update) &gt; 0]">
			<xsl:value-of select="@name"/> = <xsl:value-of select="@update"/>
			<xsl:if test="position() &lt; count(../DWColumn[contains($CreateAt,@createat) and string-length(@update) &gt; 0])">
				<xsl:value-of select="$delimiter"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="DWInsertList">
		<xsl:param name="Scope" select="'Core'"/>
		<xsl:param name="CreateAt" select="'Stage'"/>
		<xsl:param name="delimiter" select="','"/>
		<xsl:param name="unknown" select="'false'"/>
		<xsl:for-each select="/Project/Settings/DWColumns/DWColumn[contains($CreateAt,@createat) and (string-length(@insert) &gt; 0 or (@createat != 'Core' and $Scope='Core'))]">
			<xsl:choose>
				<xsl:when test="$Scope=@createat">
					<xsl:choose>
						<xsl:when test="$unknown = 'true'">
							<xsl:value-of select="@unknown"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="@insert"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$Scope='Core'">
					<xsl:choose>
						<xsl:when test="$unknown = 'true'">
							<xsl:value-of select="@unknown"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="@name"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
			
			<xsl:if test="position() &lt; count(../DWColumn[contains($CreateAt,@createat) and (string-length(@insert) &gt; 0 or (@createat != 'Core' and $Scope='Core'))])">
				<xsl:value-of select="$delimiter"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="TransformationCompare">
		<xsl:param name="delimiter" select="','"/>
		<xsl:param name="prefix" select="''"/>
		<xsl:param name="prefix2" select="''"/>
		<xsl:param name="type" select="'Key'"/>
		<xsl:param name="operation" select="'='"/>
		<xsl:param name="leftattribute" select="'Destination'"/>
		<xsl:param name="self" select="'0'"/>

		<!--get source from mapping and connection from source and staging area from connection-->
		<xsl:variable name="SourceName" select="Source/@name"/>
		<xsl:variable name="ConnectionName" select="/Project/Sources/Source[@name=$SourceName]/@connection"/>
		<xsl:variable name="StagingArea" select="/Project/Connections/Connection[@name = $ConnectionName]/StagingArea"/>

		<xsl:for-each select="Transformations/Transformation">
			<xsl:choose>
				<xsl:when test="@type = $type or $type = ''">
					<xsl:value-of select="$prefix"/>
					<xsl:if test="$leftattribute = 'Destination'">
						<xsl:choose>
							<xsl:when test="string-length($prefix) &gt; 0">
								<xsl:value-of select="hs:FullColumnName(@destination,'')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="hs:FullColumnName(@destination,../../Destination/@name)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:if test="$leftattribute = 'Source'">
						<xsl:choose>
							<xsl:when test="string-length($prefix) &gt; 0">
								<xsl:value-of select="hs:FullColumnName(@source,'')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="hs:FullColumnName(@source,concat($StagingArea,'.[',../../Source/@name,']'))"/>
								<!--
								<xsl:call-template name="Transformation">
									<xsl:with-param name="Column" select="@source"/>
									<xsl:with-param name="Table" select="concat($StagingArea,'.[',../../Source/@name,']')"/>
								</xsl:call-template>
								-->
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$operation"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$prefix2"/>
					<xsl:if test="$leftattribute = 'Destination'">
						<xsl:choose>
							<xsl:when test="$self ='0'">
								<xsl:choose>
									<xsl:when test="string-length($prefix2) &gt; 0">
										<xsl:value-of select="hs:FullColumnName(@source,'')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="hs:FullColumnName(@source,concat($StagingArea,'.[',../../Source/@name,']'))"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="string-length($prefix2) &gt; 0">
										<xsl:value-of select="hs:FullColumnName(@destination,'')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="hs:FullColumnName(@destination,../../Destination/@name)"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:if test="$leftattribute = 'Source'">
						<xsl:choose>
							<xsl:when test="$self ='0'">
								<xsl:choose>
									<xsl:when test="string-length($prefix2) &gt; 0">
										<xsl:value-of select="hs:FullColumnName(@destination,'')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="hs:FullColumnName(@destination,../../Destination/@name)"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="string-length($prefix2) &gt; 0">
										<xsl:value-of select="hs:FullColumnName(@source,'')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="hs:FullColumnName(@source,concat($StagingArea,'.[',../../Source/@name,']'))"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<!--add delimiter if not at end-->
					<xsl:variable name="pos" select="position()"/>
					<xsl:if test="count(../Transformation[position() > $pos and ( @type = $type or $type = '' ) ]) &gt; 0">
						<xsl:value-of select="$delimiter"/>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="ColumnCompare">
		<xsl:param name="delimiter" select="'&#13;&#10;		or		'"/>

		<!--get source from mapping and connection from source and staging area from connection-->
		<xsl:variable name="SourceName" select="Source/@name"/>
		<xsl:variable name="ConnectionName" select="/Project/Sources/Source[@name=$SourceName]/@connection"/>
		<xsl:variable name="StagingArea" select="/Project/Connections/Connection[@name = $ConnectionName]/StagingArea"/>
		
		<xsl:for-each select="Transformations/Transformation">
			<xsl:choose>
				<xsl:when test="@type = 'Copy'">
					<xsl:text>( </xsl:text>
					<xsl:value-of select="hs:FullColumnName(@source,concat($StagingArea,'.[',../../Source/@name,']'))"/>
					<xsl:text> &lt;&gt; </xsl:text>
					<xsl:value-of select="hs:FullColumnName(@destination,../../Destination/@name)"/>
					<xsl:text> or </xsl:text>
					<xsl:text>(</xsl:text>
					<xsl:value-of select="hs:FullColumnName(@source,concat($StagingArea,'.[',../../Source/@name,']'))"/>
					<xsl:text> is not null and </xsl:text>
					<xsl:value-of select="hs:FullColumnName(@destination,../../Destination/@name)"/>
					<xsl:text> is null </xsl:text>
					<xsl:text> ))</xsl:text>
					<!--add delimiter if not at end-->
					<xsl:variable name="pos" select="position()"/>
					<xsl:if test="count(../Transformation[position() > $pos and ( @type = 'Copy' ) ]) &gt; 0">
						<xsl:value-of select="$delimiter"/>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="TransformationList">
		<xsl:param name="delimiter" select="','"/>
		<xsl:param name="attribute" select="'destination'"/>
		<xsl:param name="prefix" select="''"/>
		<xsl:param name="type" select="''"/>
		<xsl:param name="ignore" select="0"/>

		<!--get source from mapping and connection from source and staging area from connection-->
		<xsl:variable name="SourceName" select="Source/@name"/>
		<xsl:variable name="ConnectionName" select="/Project/Sources/Source[@name=$SourceName]/@connection"/>
		<xsl:variable name="StagingArea" select="/Project/Connections/Connection[@name = $ConnectionName]/StagingArea"/>


		<xsl:for-each select="Transformations/Transformation[ ((@ignore='true' and $ignore=0) or @ignore='false')]">
			<!--only show appropriate type transformations-->
			<xsl:if test="@type = $type or $type = ''">
				<xsl:choose>
					<xsl:when test="$attribute = 'destination'">
						<xsl:value-of select="hs:FullColumnName(@destination,$prefix)"/>
					</xsl:when>
					<xsl:when test="$attribute = 'source'">
						<xsl:value-of select="hs:FullColumnName(@source,$prefix)"/>
					</xsl:when>
					<xsl:when test="$attribute = 'unknown'">
						<xsl:choose>
							<xsl:when test="@outputType = 'Int' or @outputType = 'Float' or @outputType = 'Money' or @outputType = 'Identity'">
								<xsl:value-of select="@UnknownValue"/>
							</xsl:when>
							<xsl:otherwise>
								<!--this needs quotes b/c its a string or date-->
								<xsl:text>'</xsl:text><xsl:value-of select="@UnknownValue"/>
								<xsl:text>'</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
						
					</xsl:when>
				</xsl:choose>
				<!--add delimiter if not at end-->
				<xsl:variable name="pos" select="position()"/>
				<xsl:if test="count(../Transformation[position() > $pos and ( @type = $type or $type = '' ) and ( (@ignore='true' and $ignore=0) or @ignore='false' ) ]) &gt; 0">
					<xsl:value-of select="$delimiter"/>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="CreateUnknowns">
		<!--if this is a slowly changing dimensions, add those columns here-->
		<xsl:if test="@type='Changing' or CreateIdentity = 'true'">
			set identity_insert [<xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/>] on
		</xsl:if>
		insert into [<xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/>] (
		<xsl:call-template name="TransformationList"/>
		<xsl:text>,</xsl:text>
		<xsl:call-template name="DWInsertColumnList">
			<xsl:with-param name="CreateAt" select="'Package,Stage,Core'"/>
		</xsl:call-template>
		<xsl:if test="@type='Changing' or CreateIdentity = 'true'">
			<xsl:text>,</xsl:text>
			<xsl:value-of select="hs:ReplaceAll(Destination/@name,$DimSuffix,'')"/>
			<xsl:text>ID</xsl:text>
		</xsl:if>
		)
		select	<xsl:call-template name="TransformationList">
			<xsl:with-param name="attribute" select="'unknown'"/>
			<!--<xsl:with-param name="prefix" select="concat(Source/@name,'.')"/>-->
		</xsl:call-template>
		<xsl:text>,</xsl:text>
		<xsl:call-template name="DWInsertList">
			<xsl:with-param name="Scope" select="'Core'"/>
			<xsl:with-param name="CreateAt" select="'Package,Stage,Core'"/>
			<xsl:with-param name="unknown" select="'true'" />
		</xsl:call-template>
		<xsl:if test="@type='Changing' or CreateIdentity = 'true'">
			<xsl:text>,0</xsl:text>
		</xsl:if>
		where not exists (
		select *
		from	[<xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/>] LookupTable
		)
		<xsl:if test="@type='Changing' or CreateIdentity = 'true'">
			set identity_insert [<xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/>] off
		</xsl:if>
	</xsl:template>
	<!--generate a load static procedure-->
	<xsl:template name="LoadStatic">
		<xsl:param name="ProcedureOperation" select="'create'"/>

		<!--get source from mapping and connection from source and staging area from connection-->
		<xsl:variable name="SourceName" select="Source/@name"/>
		<xsl:variable name="ConnectionName" select="/Project/Sources/Source[@name=$SourceName]/@connection"/>
		<xsl:variable name="StagingArea" select="/Project/Connections/Connection[@name = $ConnectionName]/StagingArea"/>

		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>go</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'</xsl:text>
		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="$LoadProcedureNameTemplate"/>
		</xsl:call-template>
		<xsl:text>') AND type in (N'P', N'PC'))</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>drop procedure </xsl:text>
		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="$LoadProcedureNameTemplate"/>
		</xsl:call-template>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>go</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		/***perform a static load of <xsl:value-of select="@name"/>***/
		<xsl:value-of select="$ProcedureOperation"/> procedure <xsl:call-template name="NameTemplate">
							<xsl:with-param name="Name" select="$LoadProcedureNameTemplate"/>
						</xsl:call-template>
		<xsl:call-template name="LoadFilterParams"/> as

		--print out a message for what we are doing
		--in case there is an error we will know right where it happened
		print 'Loading <xsl:value-of select="@name"  />...'

		--execute sql before the load (log step, etc)
		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="$StepPreSQL"/>
		</xsl:call-template>

		--create unknowns as needed
		<xsl:call-template name="CreateUnknowns"/>		

		--insert new rows
		insert into [<xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/>] (	
			<xsl:call-template name="TransformationList"/>
			<xsl:text>,</xsl:text>
			<xsl:call-template name="DWInsertColumnList">
				<xsl:with-param name="CreateAt" select="'Package,Stage,Core'"/>
			</xsl:call-template>
		)
		select	distinct <xsl:call-template name="TransformationList">
					<xsl:with-param name="attribute" select="'source'"/>
					<!--<xsl:with-param name="prefix" select="concat(Source/@name,'.')"/>-->
				</xsl:call-template>
		<xsl:text>,</xsl:text>
		<xsl:call-template name="DWInsertList">
			<xsl:with-param name="Scope" select="'Core'"/>
			<xsl:with-param name="CreateAt" select="'Package,Stage,Core'"/>
		</xsl:call-template>
		from	<xsl:value-of select="concat($StagingArea,'.[',Source/@name,']')"/>
		<xsl:call-template name="LoadFilter"/>
		and	not exists (
		select *
		from	[<xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/>] LookupTable
		where	<xsl:call-template name="TransformationCompare">
						<xsl:with-param name="prefix" select="'LookupTable.'"/>
						<xsl:with-param name="prefix2" select="concat($StagingArea,'.[',Source/@name,'].')"/>
						<xsl:with-param name="delimiter" select="' and '" />
						<xsl:with-param name="type" select="'Key'" />
					</xsl:call-template>

		)

		--update existing rows that have changed
		update	[<xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/>]
		set		<xsl:call-template name="TransformationCompare">
					<xsl:with-param name="prefix" select="''"/>
					<xsl:with-param name="prefix2" select="concat($StagingArea,'.[',Source/@name,'].')"/>
					<xsl:with-param name="delimiter" select="','" />
					<xsl:with-param name="type" select="'Copy'" />
				</xsl:call-template>
				<xsl:text>,</xsl:text>
				<xsl:call-template name="DWUpdateList">
					<xsl:with-param name="Scope" select="'Core'"/>
					<xsl:with-param name="CreateAt" select="'Core'"/>
				</xsl:call-template>
		from	<xsl:value-of select="concat($StagingArea,'.[',Source/@name,']')"/>
		where	<xsl:call-template name="TransformationCompare">
					<xsl:with-param name="prefix" select="''"/>
					<xsl:with-param name="prefix2" select="concat($StagingArea,'.[',Source/@name,'].')"/>
					<xsl:with-param name="delimiter" select="' and '" />
					<xsl:with-param name="type" select="'Key'" />
				</xsl:call-template>
		and		(
				<xsl:call-template name="ColumnCompare">
				</xsl:call-template>
				)

		--execute sql after the load (log step, etc)
		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="$StepPostSQL"/>
		</xsl:call-template>

		--print out a message for what we are doing
		--in case there is an error we will know right where it happened
		print 'Done Loading <xsl:value-of select="@name"  />'


	</xsl:template>
	<!--generate a load changing procedure-->
	<xsl:template name="LoadChanging">
		<xsl:param name="ProcedureOperation" select="'create'"/>

		<!--get source from mapping and connection from source and staging area from connection-->
		<xsl:variable name="SourceName" select="Source/@name"/>
		<xsl:variable name="ConnectionName" select="/Project/Sources/Source[@name=$SourceName]/@connection"/>
		<xsl:variable name="StagingArea" select="/Project/Connections/Connection[@name = $ConnectionName]/StagingArea"/>

		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>go</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'</xsl:text>
		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="$LoadProcedureNameTemplate"/>
		</xsl:call-template>
		<xsl:text>') AND type in (N'P', N'PC'))</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>drop procedure </xsl:text>
		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="$LoadProcedureNameTemplate"/>
		</xsl:call-template>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>go</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		/***perform a slowly changing load of <xsl:value-of select="@name"/>***/
		<xsl:value-of select="$ProcedureOperation"/> procedure <xsl:call-template name="NameTemplate">
							<xsl:with-param name="Name" select="$LoadProcedureNameTemplate"/>
						 </xsl:call-template>
		<xsl:call-template name="LoadFilterParams"/> as

		--print out a message for what we are doing
		--in case there is an error we will know right where it happened
		print 'Loading <xsl:value-of select="@name"  />...'


		--execute sql before the load (log step, etc)
		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="$StepPreSQL"/>
		</xsl:call-template>

		--create unknowns as needed
		<xsl:call-template name="CreateUnknowns"/>

		--insert new rows
		insert into [<xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/>] (
		<xsl:call-template name="TransformationList"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="$StartDate"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="$EndDate"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="$Active"/>
		<xsl:text>,</xsl:text>
		<xsl:call-template name="DWInsertColumnList">
			<xsl:with-param name="CreateAt" select="'Package,Stage,Core'"/>
		</xsl:call-template>
		)
		select distinct 
		<xsl:call-template name="TransformationList">
			<xsl:with-param name="attribute" select="'source'"/>
			<xsl:with-param name="prefix" select="concat($StagingArea,'.[',Source/@name,']')"/>
		</xsl:call-template>
		<xsl:text>,</xsl:text>
		<xsl:text>getdate(),null,1</xsl:text>
		<xsl:text>,</xsl:text>
		<xsl:call-template name="DWInsertList">
			<xsl:with-param name="Scope" select="'Core'"/>
			<xsl:with-param name="CreateAt" select="'Package,Stage,Core'"/>
		</xsl:call-template>
		<!--startdate, end date and active indicator-->
		from <xsl:value-of select="concat($StagingArea,'.[',Source/@name,']')"/>
		<xsl:call-template name="LoadFilter"/>
		and	not exists (
		select *
		from	[<xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/>] LookupTable
		where
		<xsl:call-template name="TransformationCompare">
			<xsl:with-param name="prefix" select="'LookupTable.'"/>
			<xsl:with-param name="prefix2" select="concat($StagingArea,'.[',Source/@name,'].')"/>
			<xsl:with-param name="delimiter" select="' and '" />
			<xsl:with-param name="type" select="'Key'" />
		</xsl:call-template>

		)

		--insert new versions of existing rows that have changed
		insert into [<xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/>] (
		<xsl:call-template name="TransformationList"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="$StartDate"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="$EndDate"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="$Active"/>
		<xsl:text>,</xsl:text>
		<xsl:call-template name="DWInsertColumnList">
			<xsl:with-param name="CreateAt" select="'Package,Stage,Core'"/>
		</xsl:call-template>
		)
		select distinct 
		<xsl:call-template name="TransformationList">
			<xsl:with-param name="attribute" select="'source'"/>
			<xsl:with-param name="prefix" select="concat($StagingArea,'.[',Source/@name,']')"/>
		</xsl:call-template>
		<xsl:text>,</xsl:text>
		<xsl:text>getdate(),null,null</xsl:text>
		<xsl:text>,</xsl:text>
		<xsl:call-template name="DWInsertList">
			<xsl:with-param name="Scope" select="'Core'"/>
			<xsl:with-param name="CreateAt" select="'Package,Stage,Core'"/>
		</xsl:call-template>
		<!--startdate, end date and active indicator (note active is null at this point)-->
		from <xsl:value-of select="concat($StagingArea,'.[',Source/@name,']')"/>
		where exists (
		select *
		from	[<xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/>] LookupTable
		where <xsl:value-of select="$Active"/> = 1
		and 
		<xsl:call-template name="TransformationCompare">
			<xsl:with-param name="prefix" select="'LookupTable.'"/>
			<xsl:with-param name="prefix2" select="concat($StagingArea,'.[',Source/@name,'].')"/>
			<xsl:with-param name="delimiter" select="' and '" />
			<xsl:with-param name="type" select="'Key'" />
		</xsl:call-template>
		and		(
				<xsl:call-template name="ColumnCompare">
				</xsl:call-template>
				)

		--inactivate the old version of rows that were replaced in this load
		update	[<xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/>]
		set		<xsl:value-of select="$Active"/> = 0,
				<xsl:value-of select="$EndDate"/> = getdate(),
				<xsl:call-template name="DWUpdateList">
					<xsl:with-param name="Scope" select="'Core'"/>
					<xsl:with-param name="CreateAt" select="'Core'"/>
				</xsl:call-template>
		where	<xsl:value-of select="$Active"/> = 1
		and		exists (
				select *
				from	[<xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/>] LookupTable
				where <xsl:value-of select="$Active"/> is null
				and
				<xsl:call-template name="TransformationCompare">
					<xsl:with-param name="prefix" select="'LookupTable.'"/>
					<xsl:with-param name="prefix2" select="concat(Destination/@name,'.')"/>
					<xsl:with-param name="delimiter" select="' and '" />
					<xsl:with-param name="type" select="'Key'" />
					<xsl:with-param name="self" select="'1'"/>
				</xsl:call-template>
				<xsl:text>		
				)
				</xsl:text>

		--update new records to active
		update	[<xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/>]
		set		<xsl:value-of select="$Active"/> = 1
		where	<xsl:value-of select="$Active"/> is null

		--execute sql after the load (log step, etc)
		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="$StepPostSQL"/>
		</xsl:call-template>

		--print out a message for what we are doing
		--in case there is an error we will know right where it happened
		print 'Done Loading <xsl:value-of select="@name"  />'


	</xsl:template>
	<xsl:template name="LoadFilterParams">
		<xsl:param name="Declare" select="'true'"/>
		<xsl:if test="count(/Project/Settings/DWColumns/DWColumn[@loadfilter='true']) &gt; 0">
			<xsl:if test="$Declare='true'">
				<xsl:text>(</xsl:text>
			</xsl:if>
			<xsl:for-each select="/Project/Settings/DWColumns/DWColumn[@loadfilter='true']">
				<xsl:text>@</xsl:text><xsl:value-of select="@name"/>
				<xsl:if test="$Declare='true'">
					<xsl:text> </xsl:text>
					<xsl:value-of select="@type"/>
					<xsl:if test="@size != 0">
						<xsl:text>(</xsl:text>
						<xsl:value-of select="@size"/>
						<xsl:text>)</xsl:text>
					</xsl:if>
				</xsl:if>
				<xsl:if test="position() &lt; count(/Project/Settings/DWColumns/DWColumn[@loadfilter='true'])">
					<xsl:text>,</xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:if test="$Declare='true'">
				<xsl:text>)</xsl:text>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="LoadFilter">
		<xsl:if test="count(/Project/Settings/DWColumns/DWColumn[@loadfilter='true']) &gt; 0">
			<xsl:text>where </xsl:text>
			<xsl:for-each select="/Project/Settings/DWColumns/DWColumn[@loadfilter='true']">
				<xsl:value-of select="@name"/> = @<xsl:value-of select="@name"/>
				<xsl:if test="position() &lt; count(/Project/Settings/DWColumns/DWColumn[@loadfilter='true'])">
					<xsl:text> and </xsl:text>
				</xsl:if>
		</xsl:for-each>
		</xsl:if>
	</xsl:template>
	<!--generate an incremental load-->
	<xsl:template name="NameTemplate">
		<xsl:param name="Name"/>
		<xsl:value-of select="hs:ReplaceAll(hs:ReplaceAll($Name,'%Mapping.Name%',@name),'%Project.Subject%',/Project/Subject)"/>
	</xsl:template>
	<xsl:template name="LoadIncremental">
		<xsl:param name="ProcedureOperation" select="'create'"/>

		<!--get source from mapping and connection from source and staging area from connection-->
		<xsl:variable name="SourceName" select="Source/@name"/>
		<xsl:variable name="ConnectionName" select="/Project/Sources/Source[@name=$SourceName]/@connection"/>
		<xsl:variable name="StagingArea" select="/Project/Connections/Connection[@name = $ConnectionName]/StagingArea"/>

		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>go</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'</xsl:text>
		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="$LoadProcedureNameTemplate"/>
		</xsl:call-template>
		<xsl:text>') AND type in (N'P', N'PC'))</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>drop procedure </xsl:text>
		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="$LoadProcedureNameTemplate"/>
		</xsl:call-template>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>go</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		/***perform an incremental load of <xsl:value-of select="@name"/>***/
		<xsl:value-of select="$ProcedureOperation"/><xsl:text> procedure </xsl:text><xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="$LoadProcedureNameTemplate"/>
		</xsl:call-template>
		<xsl:call-template name="LoadFilterParams"/><xsl:text> as </xsl:text>

		--print out a message for what we are doing
		--in case there is an error we will know right where it happened
		print 'Loading <xsl:value-of select="@name"  />...'


		--execute sql before the load (log step, etc)
		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="$StepPreSQL"/>
		</xsl:call-template>

		--insert new rows for this load
		insert into [<xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/>] (
		<!--copy columns-->
		<xsl:call-template name="TransformationList">
			<xsl:with-param name="type" select="'Copy'"/>
		</xsl:call-template>
		<!--add a comma if there are lookup columns-->
		<xsl:if test="count(Transformations/Transformation[@type='Lookup'])&gt; 0">,</xsl:if>
		<!--lookup columns-->
		<xsl:call-template name="TransformationList">
			<xsl:with-param name="type" select="'Lookup'"/>
		</xsl:call-template>
		<xsl:text>,</xsl:text>
		<xsl:call-template name="DWInsertColumnList">
			<xsl:with-param name="CreateAt" select="'Package,Stage,Core'"/>
		</xsl:call-template>
		)
		select
		<!--copy columns-->
		<xsl:call-template name="TransformationCompare">
			<!--<xsl:with-param name="prefix" select="concat(Source/@name,'.')"/>-->
			<xsl:with-param name="prefix2" select="' '"/>
			<xsl:with-param name="delimiter" select="','" />
			<xsl:with-param name="type" select="'Copy'" />
			<xsl:with-param name="operation" select="'As'"/>
			<xsl:with-param name="leftattribute" select="'Source'"/>
		</xsl:call-template>
		<!--add a comma if there are lookup columns-->
		<xsl:text>,</xsl:text>
		<!--<xsl:if test="count(Transformations/Transformation[@type='Lookup'])&gt; 0">,</xsl:if>-->
		<!--lookup columns-->
		<xsl:for-each select="Transformations/Transformation[@type='Lookup']">
			<xsl:text>isnull(Lookup</xsl:text>
			<xsl:value-of select="@destination"/>
			<xsl:text>.</xsl:text>
			<xsl:value-of select="@destination"/>
			<xsl:text>,</xsl:text><xsl:value-of select="$UnknownKey"/><xsl:text>) as </xsl:text>
			<xsl:value-of select="@destination"/>
			<!--add delimiter if not at end-->
			<xsl:variable name="pos" select="position()"/>
			<xsl:text>,</xsl:text>
		</xsl:for-each>
		<xsl:call-template name="DWInsertList">
			<xsl:with-param name="Scope" select="'Core'"/>
			<xsl:with-param name="CreateAt" select="'Package,Stage,Core'"/>
		</xsl:call-template>
		from <xsl:value-of select="concat($StagingArea,'.[',Source/@name,']')"/>
		<xsl:for-each select="Transformations/Transformation[@type='Lookup']">
			left outer join ( 
				select 
				<!--columns with alias names-->
				<xsl:for-each select="Lookup/Column">
					<xsl:value-of select="hs:FullColumnName(@name,'')"/> as
					<xsl:value-of select="hs:FullColumnName(@alias,'')"/>
					<xsl:if test="position() &lt; count(../Column)">,</xsl:if>
				</xsl:for-each>
				<!--add source if not an alias-->
				<xsl:if test="count(Lookup/Column[@alias=../../@source]) = 0">
					<xsl:if test="count(Lookup/Column) &gt; 0">,</xsl:if>
					<xsl:value-of select="hs:FullColumnName(@source,'')"/>
				</xsl:if>
				<!--add destination if not an alias-->
				<xsl:if test="count(Lookup/Column[@alias=../../@destination]) = 0">
					,<xsl:value-of select="hs:FullColumnName(@destination,'')"/>
				</xsl:if>
				from <xsl:value-of select="Lookup/@destination"/>
				<xsl:if test="Lookup/Filter != ''">
				where <xsl:value-of select="Lookup/Filter"/>
			</xsl:if>
		) Lookup<xsl:value-of select="@destination"/> on (
			<xsl:value-of select="hs:FullColumnName(@source,concat($StagingArea,'.[',../../Source/@name,']'))"/><xsl:text> = Lookup</xsl:text>
			<xsl:value-of select="@destination"/>
			<xsl:text>.</xsl:text>
			<xsl:value-of select="hs:FullColumnName(@source,'')"/>
			)			
		</xsl:for-each>
		<xsl:call-template name="LoadFilter"/>			
		

		--execute sql after the load (log step, etc)
		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="$StepPostSQL"/>
		</xsl:call-template>

		--print out a message for what we are doing
		--in case there is an error we will know right where it happened
		print 'Done Loading <xsl:value-of select="@name"  />'


	</xsl:template>
	<xsl:template name="LoadAll">
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>go</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		
		<xsl:text>IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'</xsl:text>
		<!--call name template but in this case our mapping is the subject name so replace that first
			that way we avoid having yet another setting in the project (for the "load all" procedure name)
		-->		
		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="hs:ReplaceAll($LoadProcedureNameTemplate,'%Mapping.Name%','%Project.Subject%')"/>
		</xsl:call-template>
		<xsl:text>') AND type in (N'P', N'PC'))</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>drop procedure </xsl:text>
		<!--call name template but in this case our mapping is the subject name so replace that first
			that way we avoid having yet another setting in the project (for the "load all" procedure name)
		-->
		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="hs:ReplaceAll($LoadProcedureNameTemplate,'%Mapping.Name%','%Project.Subject%')"/>
		</xsl:call-template>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>go</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>/***perform an incremental load of </xsl:text><xsl:value-of select="@name"/><xsl:text>***/</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>create procedure </xsl:text>
		<!--call name template but in this case our mapping is the subject name so replace that first
			that way we avoid having yet another setting in the project (for the "load all" procedure name)
		-->

		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="hs:ReplaceAll($LoadProcedureNameTemplate,'%Mapping.Name%','%Project.Subject%')"/>
		</xsl:call-template>
		<xsl:call-template name="LoadFilterParams"/><xsl:text> as</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>&#13;&#10;/*load all dimensions*/</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:for-each select="Mappings/Mapping[@type!='Incremental']">
			<!--create procedure-->
			<xsl:text>exec </xsl:text>
			<xsl:call-template name="NameTemplate">
				<xsl:with-param name="Name" select="$LoadProcedureNameTemplate"/>
			</xsl:call-template>
			<!--list all procedure parameters but don't declare them, use pass them through-->
			<xsl:text> </xsl:text>
			<xsl:call-template name="LoadFilterParams">
				<xsl:with-param name="Declare" select="'false'"/>
			</xsl:call-template>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:for-each>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>&#13;&#10;/*load all facts*/</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:for-each select="Mappings/Mapping[@type='Incremental']">
			<!--create procedure-->
			<xsl:text>exec </xsl:text>
			<xsl:call-template name="NameTemplate">
				<xsl:with-param name="Name" select="$LoadProcedureNameTemplate"/>
			</xsl:call-template>
			<!--list all procedure parameters but don't declare them, use pass them through-->
			<xsl:text> </xsl:text>
			<xsl:call-template name="LoadFilterParams">
				<xsl:with-param name="Declare" select="'false'"/>
			</xsl:call-template>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="ClearAll">
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>go</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>

		<xsl:text>IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'</xsl:text>
		<!--call name template but in this case our mapping is the subject name so replace that first
			that way we avoid having yet another setting in the project (for the "load all" procedure name)
		-->
		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="hs:ReplaceAll(hs:ReplaceAll($LoadProcedureNameTemplate,'%Mapping.Name%','%Project.Subject%'),'Load','Reset')"/>
		</xsl:call-template>
		<xsl:text>') AND type in (N'P', N'PC'))</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>drop procedure </xsl:text>
		<!--call name template but in this case our mapping is the subject name so replace that first
			that way we avoid having yet another setting in the project (for the "load all" procedure name)
		-->
		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="hs:ReplaceAll(hs:ReplaceAll($LoadProcedureNameTemplate,'%Mapping.Name%','%Project.Subject%'),'Load','Reset')"/>
		</xsl:call-template>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>go</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>/***perform a full reset (truncating all tables) of </xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>***/</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>create procedure </xsl:text>
		<!--call name template but in this case our mapping is the subject name so replace that first
			that way we avoid having yet another setting in the project (for the "load all" procedure name)
		-->

		<xsl:call-template name="NameTemplate">
			<xsl:with-param name="Name" select="hs:ReplaceAll(hs:ReplaceAll($LoadProcedureNameTemplate,'%Mapping.Name%','%Project.Subject%'),'Load','Reset')"/>
		</xsl:call-template>
		<xsl:text> as</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>&#13;&#10;/*truncate all fact tables*/</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:for-each select="Mappings/Mapping[@type='Incremental']">
			<!--truncate the table-->
			<xsl:text>truncate table </xsl:text>
			<xsl:text>[</xsl:text><xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/><xsl:text>]</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:for-each>
		<xsl:if test="$ResetDimensions = 'True'">
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:text>&#13;&#10;/*truncate all dimension tables*/</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:for-each select="Mappings/Mapping[@type!='Incremental']">
				<!--truncate the table-->
				<xsl:text>truncate table </xsl:text>
				<xsl:text>[</xsl:text><xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="Destination/@name"/><xsl:text>]</xsl:text>
				<xsl:text>&#13;&#10;</xsl:text>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
