<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hs="urn:HyperStarExtensions">
	<!--global variables-->
	<xsl:variable name="StartDate" select="/Project/Settings/StartDate"/>
	<xsl:variable name="EndDate" select="/Project/Settings/EndDate"/>
	<xsl:variable name="Active" select="/Project/Settings/Active"/>
	<xsl:variable name="UnknownKey" select="/Project/Settings/UnknownKey"/>
	<xsl:variable name="LoadProcedureNameTemplate" select="/Project/Settings/LoadProcedureNameTemplate"/>
	<xsl:variable name="ConstraintProcedureNameTemplate" select="/Project/Settings/ConstraintProcedureNameTemplate"/>
	<xsl:variable name="StepPreSQL" select="/Project/Settings/StepPreSQL"/>
	<xsl:variable name="StepPostSQL" select="/Project/Settings/StepPostSQL"/>
	<xsl:variable name="DimSuffix" select="/Project/Settings/Other/Setting[@name='DimSuffix']/@value"/>

	<xsl:template match="/Project">
		<xsl:element name="Output">
			<xsl:choose>
				<xsl:when test="/Project/Settings/Other/Setting[@name='OneFile']/@value='true'">
					<!--here we are generating one single file for both commands-->
					
					<!--add procedure-->
					<xsl:element name="OutputFile">
						<xsl:attribute name="name">
							<xsl:text>Constraints</xsl:text>
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


						<xsl:call-template name="AddConstraints"/>

						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>go</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:text>&#13;&#10;</xsl:text>
						<xsl:call-template name="DropConstraints"/>

					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<!--here we are generating one file per command-->
					
					<!--add procedure-->
					<xsl:element name="OutputFile">
						<xsl:attribute name="name">
							<xsl:text>create AddConstraints</xsl:text>
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


						<xsl:call-template name="AddConstraints"/>
					</xsl:element>
					<!--drop procedure-->
					<xsl:element name="OutputFile">
						<xsl:attribute name="name">
							<xsl:text>create DropConstraints</xsl:text>
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


						<xsl:call-template name="DropConstraints"/>
					</xsl:element>					
					
				</xsl:otherwise>
			</xsl:choose>			
			

		</xsl:element>
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
					<xsl:value-of select="hs:ColumnType(@type,@size,'NULL')"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="position() &lt; count(../DWColumn[contains($CreateAt,@createat)])">
				<xsl:value-of select="$delimiter"/>
			<xsl:text>
			</xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="AddConstraints">
		<xsl:variable name="ProcedureName" select="hs:ReplaceAll(hs:ReplaceAll($ConstraintProcedureNameTemplate,'%Project.Subject%',/Project/Subject),'%Operation%','Add')"/>
		<xsl:text>&#13;&#10;IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[</xsl:text><xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text><xsl:value-of select="$ProcedureName"/><xsl:text>]') AND type in (N'P', N'PC'))</xsl:text>
		<xsl:text>&#13;&#10;DROP PROCEDURE </xsl:text>
		<xsl:text>[</xsl:text><xsl:value-of select="/Project/Subject"/><xsl:text>].</xsl:text>
		<xsl:text>[</xsl:text><xsl:value-of select="$ProcedureName"/><xsl:text>]</xsl:text>
		<xsl:text>&#13;&#10;GO</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>create procedure [</xsl:text><xsl:value-of select="/Project/Subject"/><xsl:text>].</xsl:text><xsl:value-of select="$ProcedureName"/><xsl:text> </xsl:text> as
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>/***ADD STATIC CONSTRAINTS***/</xsl:text>
		<xsl:for-each select="Mappings/Mapping[contains('Static',@type) and ( count(Transformations/Transformation[@type='Key']) &gt; 0 or CreateIdentity = 'true') ]">
			<xsl:variable name="PrimaryTable" select="Destination/@name"/>
			<xsl:text>&#13;&#10;alter table </xsl:text>
			<xsl:text>[</xsl:text><xsl:value-of select="/Project/Subject"/><xsl:text>].</xsl:text><xsl:value-of select="$PrimaryTable"/>
			<xsl:text>&#13;&#10;add constraint pk_</xsl:text>
			<xsl:value-of select="$PrimaryTable"/>
			<xsl:text> primary key clustered</xsl:text>
			<xsl:text>&#13;&#10;(</xsl:text>
			<xsl:choose>
				<xsl:when test="CreateIdentity = 'true'">
					<!--this table has a surrogate key so use it instead-->
					<xsl:value-of select="hs:ReplaceAll(Destination/@name,$DimSuffix,'')"/><xsl:text>ID</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<!--use defined key columns-->
					<xsl:for-each select="Transformations/Transformation[@type='Key']">
						<xsl:variable name="PrimaryKey" select="@destination"/>
						<xsl:text>[</xsl:text>
						<xsl:value-of select="$PrimaryKey"/>
						<xsl:text>] ASC</xsl:text>
						<!--add next key column if needed-->
						<xsl:if test="position() &lt; count(../Transformation[@type='Key'])">
							<xsl:text>,</xsl:text>
						</xsl:if>
						<xsl:text>&#13;&#10;</xsl:text>
					</xsl:for-each>

				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>)&#13;&#10;WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:for-each>
		<xsl:text>/***ADD SLOWLY CHANGING DIMENSION CONSTRAINTS***/</xsl:text>
		<xsl:for-each select="Mappings/Mapping[contains('Changing',@type)]">
			
			<xsl:variable name="PrimaryTable" select="Destination/@name"/>
			<xsl:text>&#13;&#10;alter table </xsl:text>
			<xsl:text>[</xsl:text><xsl:value-of select="/Project/Subject"/><xsl:text>].</xsl:text><xsl:value-of select="$PrimaryTable"/>
			<xsl:text>&#13;&#10;add constraint pk_</xsl:text>
			<xsl:value-of select="$PrimaryTable"/>
			<xsl:text> primary key clustered</xsl:text>
			<xsl:text>&#13;&#10;(</xsl:text>
			<xsl:text>[</xsl:text>
			<xsl:value-of select="hs:ReplaceAll(Destination/@name,$DimSuffix,'')"/><xsl:text>ID</xsl:text>
			<xsl:text>] ASC</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:text>)&#13;&#10;WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:for-each>
		<xsl:text>/***ADD FACT CONSTRAINTS***/</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:for-each select="Mappings/Mapping[@type='Incremental']/Transformations/Transformation[@constraint!='']">
			<xsl:variable name="ForeignTable" select="../../Destination/@name"/>
			<xsl:variable name="PrimaryTable" select="hs:ConstraintTable(@constraint,@destination)"/>
			<xsl:variable name="ForeignKey" select="@destination"/>
			<xsl:variable name="PrimaryKey" select="hs:ConstraintColumn(@constraint,@destination)"/>
			<xsl:text>alter table </xsl:text>
			<xsl:text>[</xsl:text><xsl:value-of select="/Project/Subject"/><xsl:text>].</xsl:text><xsl:value-of select="$ForeignTable"/>
			<xsl:text>&#13;&#10; add constraint FK_</xsl:text><xsl:value-of select="$ForeignTable"/>_<xsl:value-of select="$ForeignKey"/><xsl:text> foreign key </xsl:text>
			<xsl:text>&#13;&#10;(</xsl:text><xsl:value-of select="$ForeignKey"/><xsl:text>)</xsl:text><xsl:text> references </xsl:text><xsl:text>[</xsl:text><xsl:value-of select="/Project/Subject"/><xsl:text>].</xsl:text><xsl:value-of select="$PrimaryTable"/>
			<xsl:text>&#13;&#10;(</xsl:text><xsl:value-of select="$PrimaryKey"/><xsl:text>)</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="DropConstraints">
		<xsl:variable name="ProcedureName" select="hs:ReplaceAll(hs:ReplaceAll($ConstraintProcedureNameTemplate,'%Project.Subject%',/Project/Subject),'%Operation%','Drop')"/>
		<xsl:text>&#13;&#10;IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'</xsl:text>
		<xsl:text>[</xsl:text><xsl:value-of select="/Project/Subject"/><xsl:text>].[</xsl:text>
		<xsl:value-of select="$ProcedureName"/><xsl:text>]') AND type in (N'P', N'PC'))</xsl:text>
		<xsl:text>&#13;&#10;DROP PROCEDURE </xsl:text>
		<xsl:text>[</xsl:text><xsl:value-of select="/Project/Subject"/><xsl:text>].</xsl:text>
		<xsl:text>[</xsl:text><xsl:value-of select="$ProcedureName"/><xsl:text>]</xsl:text>
		<xsl:text>&#13;&#10;GO</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>create procedure </xsl:text>
		<xsl:text>[</xsl:text><xsl:value-of select="/Project/Subject"/><xsl:text>].</xsl:text>
		<xsl:value-of select="$ProcedureName"/><xsl:text> </xsl:text> as
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>/***DROP FACT CONSTRAINTS***/</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:for-each select="Mappings/Mapping[@type='Incremental']/Transformations/Transformation[@constraint!='']">
			<xsl:variable name="TableName" select="../../Destination/@name"/>
			<xsl:variable name="ForeignKey" select="@destination"/>
			<xsl:variable name="PrimaryTable" select="hs:ConstraintTable(@constraint,@destination)"/>
			<xsl:text>alter table </xsl:text>
			<xsl:text>[</xsl:text><xsl:value-of select="/Project/Subject"/><xsl:text>].</xsl:text><xsl:value-of select="$TableName"/>
			<xsl:text> drop constraint FK_</xsl:text><xsl:value-of select="$TableName"/>_<xsl:value-of select="@destination"/>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:for-each>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>/***DROP DIMENSION CONSTRAINTS***/</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<!--there is only 1 primary key per destination mapping table, find them and drop them-->
		<xsl:for-each select="Mappings/Mapping[contains('Changing,Static',@type) and count(Transformations/Transformation[@type='Key']) &gt; 0]">
			<xsl:variable name="PrimaryTable" select="Destination/@name"/>
			<xsl:text>alter table </xsl:text>
			<xsl:text>[</xsl:text><xsl:value-of select="/Project/Subject"/><xsl:text>].</xsl:text><xsl:value-of select="$PrimaryTable"/>
			<xsl:text> drop constraint PK_</xsl:text><xsl:value-of select="$PrimaryTable"/>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:for-each>
		<xsl:text>&#13;&#10;</xsl:text>
	</xsl:template>
</xsl:stylesheet>
