<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hs="urn:HyperStarExtensions">
	<!--global variables-->
	<xsl:variable name="StartDate" select="/Project/Settings/StartDate"/>
	<xsl:variable name="EndDate" select="/Project/Settings/EndDate"/>
	<xsl:variable name="Active" select="/Project/Settings/Active"/>
	<xsl:variable name="UnknownKey" select="/Project/Settings/UnknownKey"/>
	<xsl:variable name="LoadProcedureNameTemplate" select="/Project/Settings/LoadProcedureNameTemplate"/>
	<xsl:variable name="StepPreSQL" select="/Project/Settings/StepPreSQL"/>
	<xsl:variable name="StepPostSQL" select="/Project/Settings/StepPostSQL"/>
	<xsl:variable name="DimSuffix" select="/Project/Settings/Other/Setting[@name='DimSuffix']/@value"/>

	<xsl:template match="/Project">
		<xsl:element name="Output">
			<!--generate create scripts for each load procedure-->
			<xsl:choose>
				<xsl:when test="/Project/Settings/Other/Setting[@name='OneFile']/@value='true'">
					<!--create in one file-->
					<xsl:element name="OutputFile">
						<xsl:attribute name="name">
							<xsl:text>create Stage Schema</xsl:text>
							<xsl:text>.sql</xsl:text>
						</xsl:attribute>

						<!--use command-->
						<xsl:text>/*********************************************************/</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>use&#09;</xsl:text>
						<xsl:value-of select="/Project/Settings/Other/Setting[@name='StageDatabase']/@value"/>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>go</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>/*********************************************************/</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<!--use command-->


						<xsl:for-each select="Sources/Source[Derived='false']">
							<xsl:call-template name="StageTable">
								<xsl:with-param name="CreateOperation" select="'create'"/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:element>

				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="Sources/Source[Derived='false']">
						<!--create procedure-->
						<xsl:element name="OutputFile">
							<xsl:attribute name="name">
								<xsl:text>create </xsl:text>
								<xsl:value-of select="@name"/>
								<xsl:text>.sql</xsl:text>
							</xsl:attribute>

							<!--use command-->
							<xsl:text>/*********************************************************/</xsl:text>
							<xsl:text>&#13;&#10;</xsl:text>
							<xsl:text>use&#09;</xsl:text>
							<xsl:value-of select="/Project/Settings/Other/Setting[@name='StageDatabase']/@value"/>
							<xsl:text>&#13;&#10;</xsl:text>
							<xsl:text>go</xsl:text>
							<xsl:text>&#13;&#10;</xsl:text>
							<xsl:text>/*********************************************************/</xsl:text>
							<xsl:text>&#13;&#10;</xsl:text>
							<!--use command-->


							<xsl:call-template name="StageTable">
								<xsl:with-param name="CreateOperation" select="'create'"/>
							</xsl:call-template>
						</xsl:element>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="TableName">
		
	</xsl:template>
	<xsl:template name="DWColumnCreateList">
		<xsl:param name="CreateAt" select="'Stage'"/>
		<xsl:param name="Scope" select="'Stage'"/>
		<xsl:param name="delimiter" select="','"/>
		<xsl:for-each select="/Project/Settings/DWColumns/DWColumn[contains($CreateAt,@createat)]">
			<xsl:value-of select="@name"/>
			<xsl:text> </xsl:text>
			<xsl:choose>
				<!--don't create idenitity type column except for in the scope they are creatd
				all other scopes should be just regular integers, b/c the value is copied over
				-->
				<xsl:when test="$Scope='Core' and @createat!='Core' and @type='Identity'">
					<xsl:text> [int] not null</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="hs:ColumnType(@type,@size,'Null')"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="position() &lt; count(../DWColumn[contains($CreateAt,@createat)])">
				<xsl:value-of select="$delimiter"/>
				<xsl:text>
			</xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="StageTable">
		<xsl:param name="CreateOperation" select="'create'"/>
		<xsl:text>IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'</xsl:text>
		<xsl:variable name="ConnectionName" select="@connection"/>
		<xsl:variable name="StagingArea" select="/Project/Connections/Connection[@name = $ConnectionName]/StagingArea"/>
		<xsl:value-of select="$StagingArea"/>
		<xsl:text>.[</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>]') AND type in (N'T', N'U'))</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>drop table </xsl:text>
		<xsl:value-of select="$StagingArea"/>.[<xsl:value-of select="@name"/>]
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>go</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:value-of select="$CreateOperation"/><xsl:text> table </xsl:text>
		<xsl:value-of select="$StagingArea"/>.[<xsl:value-of select="@name"/>]
		<xsl:text>(</xsl:text>
		<xsl:text>&#13;&#10;&#09;&#09;&#09;</xsl:text>
		<xsl:for-each select="Column[@ignore='false']">
			<!--write column name-->
			<xsl:value-of select="hs:FullColumnName(@alias,'')"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="hs:ColumnType(@type,@size,'Null')"/>
			<!--add a comma-->
			<!--<xsl:if test="position() &lt; count(../Column[@ignore='false'])">-->
				<xsl:text>,</xsl:text>
			<!--</xsl:if>-->
			<xsl:text>&#13;&#10;&#09;&#09;&#09;</xsl:text>
		</xsl:for-each>
		<xsl:call-template name="DWColumnCreateList">
			<xsl:with-param name="CreateAt" select="'Stage,Package'"/>
			<xsl:with-param name="Scope" select="'Stage'"/>
		</xsl:call-template>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>)</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>go</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
	</xsl:template>
</xsl:stylesheet>
