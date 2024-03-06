<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hs="urn:HyperStarExtensions">
	<!--global variables-->
	<xsl:variable name="StartDate" select="/Project/Settings/StartDate"/>
	<xsl:variable name="EndDate" select="/Project/Settings/EndDate"/>
	<xsl:variable name="Active" select="/Project/Settings/Active"/>
	<xsl:variable name="UnknownKey" select="/Project/Settings/UnknownKey"/>
	<xsl:variable name="LoadProcedureNameTemplate" select="/Project/Settings/LoadProcedureNameTemplate"/>
	<xsl:variable name="StepPreSQL" select="/Project/Settings/StepPreSQL"/>
	<xsl:variable name="StepPostSQL" select="/Project/Settings/StepPostSQL"/>

	<xsl:template match="/Project">
		<xsl:element name="Output">
			<!--create a single ssis package-->
			<xsl:element name="OutputFile">
				<xsl:attribute name="name">
					<xsl:text>Load </xsl:text>
					<xsl:value-of select="Subject"/>
					<xsl:text>.dtsx</xsl:text>
			</xsl:attribute>
			<xsl:call-template name="CreatePackage">
			</xsl:call-template>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template name="Pipeline">
		<xsl:param name="ConnectionName"/>
		<![CDATA[<DTS:Executable DTS:ExecutableType="SSIS.Pipeline.2">
<DTS:Property DTS:Name="ExecutionLocation">0</DTS:Property>
<DTS:Property DTS:Name="ExecutionAddress"></DTS:Property>
<DTS:Property DTS:Name="TaskContact">Performs high-performance data extraction, transformation and loading;Microsoft Corporation; Microsoft SQL Server v10; (C) 2007 Microsoft Corporation; All Rights Reserved;http://www.microsoft.com/sql/support/default.asp;1</DTS:Property>
<DTS:Property DTS:Name="ForceExecValue">0</DTS:Property>
<DTS:Property DTS:Name="ExecValue" DTS:DataType="3">0</DTS:Property>
<DTS:Property DTS:Name="ForceExecutionResult">-1</DTS:Property>
<DTS:Property DTS:Name="Disabled">0</DTS:Property>
<DTS:Property DTS:Name="FailPackageOnFailure">0</DTS:Property>
<DTS:Property DTS:Name="FailParentOnFailure">0</DTS:Property>
<DTS:Property DTS:Name="MaxErrorCount">1</DTS:Property>
<DTS:Property DTS:Name="ISOLevel">1048576</DTS:Property>
<DTS:Property DTS:Name="LocaleID">-1</DTS:Property>
<DTS:Property DTS:Name="TransactionOption">1</DTS:Property>
<DTS:Property DTS:Name="DelayValidation">0</DTS:Property>
<DTS:LoggingOptions>
<DTS:Property DTS:Name="LoggingMode">0</DTS:Property>
<DTS:Property DTS:Name="FilterKind">1</DTS:Property>
<DTS:Property DTS:Name="EventFilter" DTS:DataType="8"></DTS:Property></DTS:LoggingOptions>
<DTS:Property DTS:Name="ObjectName">Data Flow Task</DTS:Property>
<DTS:Property DTS:Name="DTSID">{2F5CC040-93D7-4850-8512-466DA6C06E0B}</DTS:Property>
<DTS:Property DTS:Name="Description">Data Flow Task</DTS:Property>
<DTS:Property DTS:Name="CreationName">SSIS.Pipeline.2</DTS:Property>
<DTS:Property DTS:Name="DisableEventHandlers">0</DTS:Property><DTS:ObjectData><pipeline id="0" name="pipelineXml" description="pipelineXml" defaultBufferMaxRows="10000" engineThreads="10" defaultBufferSize="10485760" BLOBTempStoragePath="" bufferTempStoragePath="" runInOptimizedMode="true">
<components>
<component id="1" name="Flat File Source" componentClassID="{5ACD952A-F16A-41D8-A681-713640837664}" description="Flat File Source" localeId="1033" usesDispositions="true" validateExternalMetadata="True" version="1" pipelineVersion="0" contactInfo="Flat File Source;Microsoft Corporation; Microsoft SqlServer v10; (C) Microsoft Corporation; All Rights Reserved; http://www.microsoft.com/sql/support;1">
<properties>
<property id="7" name="RetainNulls" dataType="System.Boolean" state="default" isArray="false" description="Specifies whether zero-length columns are treated as null." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="8" name="FileNameColumnName" dataType="System.String" state="default" isArray="false" description="Specifies the name of an output column containing the file name. If no name is specified, no output column containing the file name will be generated." typeConverter="" UITypeEditor="" containsID="false" expressionType="None"></property></properties>
<connections>
<connection id="6" name="FlatFileConnection" description="" connectionManagerID="]]><xsl:value-of select="hs:Guid($ConnectionName)"/><![CDATA["/></connections>
<outputs>
<output id="2" name="Flat File Source Output" description="" exclusionGroup="0" synchronousInputId="0" deleteOutputOnPathDetached="false" hasSideEffects="false" dangling="false" isErrorOut="false" isSorted="false" errorOrTruncationOperation="" errorRowDisposition="NotUsed" truncationRowDisposition="NotUsed"><outputColumns>
<outputColumn id="28" name="Emplid" description="" lineageId="28" precision="0" scale="0" length="50" dataType="str" codePage="1252" sortKeyPosition="0" comparisonFlags="0" specialFlags="0" errorOrTruncationOperation="Conversion" errorRowDisposition="FailComponent" truncationRowDisposition="FailComponent" externalMetadataColumnId="27" mappedColumnId="0"><properties>
<property id="29" name="FastParse" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the column uses the faster, locale-neutral parsing routines." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="30" name="UseBinaryFormat" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the data is in binary format." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property></properties></outputColumn>
<outputColumn id="32" name="HRB Name" description="" lineageId="32" precision="0" scale="0" length="50" dataType="str" codePage="1252" sortKeyPosition="0" comparisonFlags="0" specialFlags="0" errorOrTruncationOperation="Conversion" errorRowDisposition="FailComponent" truncationRowDisposition="FailComponent" externalMetadataColumnId="31" mappedColumnId="0"><properties>
<property id="33" name="FastParse" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the column uses the faster, locale-neutral parsing routines." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="34" name="UseBinaryFormat" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the data is in binary format." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property></properties></outputColumn>
<outputColumn id="36" name="Functional Title" description="" lineageId="36" precision="0" scale="0" length="50" dataType="str" codePage="1252" sortKeyPosition="0" comparisonFlags="0" specialFlags="0" errorOrTruncationOperation="Conversion" errorRowDisposition="FailComponent" truncationRowDisposition="FailComponent" externalMetadataColumnId="35" mappedColumnId="0"><properties>
<property id="37" name="FastParse" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the column uses the faster, locale-neutral parsing routines." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="38" name="UseBinaryFormat" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the data is in binary format." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property></properties></outputColumn>
<outputColumn id="40" name="Name" description="" lineageId="40" precision="0" scale="0" length="50" dataType="str" codePage="1252" sortKeyPosition="0" comparisonFlags="0" specialFlags="0" errorOrTruncationOperation="Conversion" errorRowDisposition="FailComponent" truncationRowDisposition="FailComponent" externalMetadataColumnId="39" mappedColumnId="0"><properties>
<property id="41" name="FastParse" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the column uses the faster, locale-neutral parsing routines." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="42" name="UseBinaryFormat" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the data is in binary format." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property></properties></outputColumn>
<outputColumn id="44" name="Device" description="" lineageId="44" precision="0" scale="0" length="50" dataType="str" codePage="1252" sortKeyPosition="0" comparisonFlags="0" specialFlags="0" errorOrTruncationOperation="Conversion" errorRowDisposition="FailComponent" truncationRowDisposition="FailComponent" externalMetadataColumnId="43" mappedColumnId="0"><properties>
<property id="45" name="FastParse" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the column uses the faster, locale-neutral parsing routines." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="46" name="UseBinaryFormat" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the data is in binary format." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property></properties></outputColumn>
<outputColumn id="48" name="Number" description="" lineageId="48" precision="0" scale="0" length="50" dataType="str" codePage="1252" sortKeyPosition="0" comparisonFlags="0" specialFlags="0" errorOrTruncationOperation="Conversion" errorRowDisposition="FailComponent" truncationRowDisposition="FailComponent" externalMetadataColumnId="47" mappedColumnId="0"><properties>
<property id="49" name="FastParse" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the column uses the faster, locale-neutral parsing routines." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="50" name="UseBinaryFormat" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the data is in binary format." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property></properties></outputColumn>
<outputColumn id="52" name="Carrier" description="" lineageId="52" precision="0" scale="0" length="50" dataType="str" codePage="1252" sortKeyPosition="0" comparisonFlags="0" specialFlags="0" errorOrTruncationOperation="Conversion" errorRowDisposition="FailComponent" truncationRowDisposition="FailComponent" externalMetadataColumnId="51" mappedColumnId="0"><properties>
<property id="53" name="FastParse" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the column uses the faster, locale-neutral parsing routines." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="54" name="UseBinaryFormat" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the data is in binary format." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property></properties></outputColumn>
<outputColumn id="56" name="Type" description="" lineageId="56" precision="0" scale="0" length="50" dataType="str" codePage="1252" sortKeyPosition="0" comparisonFlags="0" specialFlags="0" errorOrTruncationOperation="Conversion" errorRowDisposition="FailComponent" truncationRowDisposition="FailComponent" externalMetadataColumnId="55" mappedColumnId="0"><properties>
<property id="57" name="FastParse" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the column uses the faster, locale-neutral parsing routines." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="58" name="UseBinaryFormat" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the data is in binary format." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property></properties></outputColumn>
<outputColumn id="60" name="Group" description="" lineageId="60" precision="0" scale="0" length="50" dataType="str" codePage="1252" sortKeyPosition="0" comparisonFlags="0" specialFlags="0" errorOrTruncationOperation="Conversion" errorRowDisposition="FailComponent" truncationRowDisposition="FailComponent" externalMetadataColumnId="59" mappedColumnId="0"><properties>
<property id="61" name="FastParse" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the column uses the faster, locale-neutral parsing routines." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="62" name="UseBinaryFormat" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the data is in binary format." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property></properties></outputColumn>
<outputColumn id="64" name="Property ID" description="" lineageId="64" precision="0" scale="0" length="50" dataType="str" codePage="1252" sortKeyPosition="0" comparisonFlags="0" specialFlags="0" errorOrTruncationOperation="Conversion" errorRowDisposition="FailComponent" truncationRowDisposition="FailComponent" externalMetadataColumnId="63" mappedColumnId="0"><properties>
<property id="65" name="FastParse" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the column uses the faster, locale-neutral parsing routines." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="66" name="UseBinaryFormat" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the data is in binary format." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property></properties></outputColumn>
<outputColumn id="68" name="Location" description="" lineageId="68" precision="0" scale="0" length="50" dataType="str" codePage="1252" sortKeyPosition="0" comparisonFlags="0" specialFlags="0" errorOrTruncationOperation="Conversion" errorRowDisposition="FailComponent" truncationRowDisposition="FailComponent" externalMetadataColumnId="67" mappedColumnId="0"><properties>
<property id="69" name="FastParse" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the column uses the faster, locale-neutral parsing routines." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="70" name="UseBinaryFormat" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the data is in binary format." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property></properties></outputColumn>
<outputColumn id="72" name="Device Start Date" description="" lineageId="72" precision="0" scale="0" length="50" dataType="str" codePage="1252" sortKeyPosition="0" comparisonFlags="0" specialFlags="0" errorOrTruncationOperation="Conversion" errorRowDisposition="FailComponent" truncationRowDisposition="FailComponent" externalMetadataColumnId="71" mappedColumnId="0"><properties>
<property id="73" name="FastParse" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the column uses the faster, locale-neutral parsing routines." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="74" name="UseBinaryFormat" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the data is in binary format." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property></properties></outputColumn>
<outputColumn id="76" name="Contract End" description="" lineageId="76" precision="0" scale="0" length="50" dataType="str" codePage="1252" sortKeyPosition="0" comparisonFlags="0" specialFlags="0" errorOrTruncationOperation="Conversion" errorRowDisposition="FailComponent" truncationRowDisposition="FailComponent" externalMetadataColumnId="75" mappedColumnId="0"><properties>
<property id="77" name="FastParse" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the column uses the faster, locale-neutral parsing routines." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="78" name="UseBinaryFormat" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the data is in binary format." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property></properties></outputColumn>
<outputColumn id="80" name="Last Upgrade" description="" lineageId="80" precision="0" scale="0" length="50" dataType="str" codePage="1252" sortKeyPosition="0" comparisonFlags="0" specialFlags="0" errorOrTruncationOperation="Conversion" errorRowDisposition="FailComponent" truncationRowDisposition="FailComponent" externalMetadataColumnId="79" mappedColumnId="0"><properties>
<property id="81" name="FastParse" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the column uses the faster, locale-neutral parsing routines." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="82" name="UseBinaryFormat" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the data is in binary format." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property></properties></outputColumn>
<outputColumn id="84" name="Comments" description="" lineageId="84" precision="0" scale="0" length="50" dataType="str" codePage="1252" sortKeyPosition="0" comparisonFlags="0" specialFlags="0" errorOrTruncationOperation="Conversion" errorRowDisposition="FailComponent" truncationRowDisposition="FailComponent" externalMetadataColumnId="83" mappedColumnId="0"><properties>
<property id="85" name="FastParse" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the column uses the faster, locale-neutral parsing routines." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="86" name="UseBinaryFormat" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the data is in binary format." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property></properties></outputColumn></outputColumns><externalMetadataColumns isUsed="True">
<externalMetadataColumn id="27" name="Emplid" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="31" name="HRB Name" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="35" name="Functional Title" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="39" name="Name" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="43" name="Device" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="47" name="Number" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="51" name="Carrier" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="55" name="Type" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="59" name="Group" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="63" name="Property ID" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="67" name="Location" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="71" name="Device Start Date" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="75" name="Contract End" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="79" name="Last Upgrade" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="83" name="Comments" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/></externalMetadataColumns></output>
<output id="3" name="Flat File Source Error Output" description="" exclusionGroup="0" synchronousInputId="0" deleteOutputOnPathDetached="false" hasSideEffects="false" dangling="false" isErrorOut="true" isSorted="false" errorOrTruncationOperation="" errorRowDisposition="NotUsed" truncationRowDisposition="NotUsed"><outputColumns>
<outputColumn id="87" name="Flat File Source Error Output Column" description="Flat File Source Error Output Column" lineageId="87" precision="0" scale="0" length="0" dataType="text" codePage="1252" sortKeyPosition="0" comparisonFlags="0" specialFlags="0" errorOrTruncationOperation="" errorRowDisposition="NotUsed" truncationRowDisposition="NotUsed" externalMetadataColumnId="0" mappedColumnId="0"/>
<outputColumn id="4" name="ErrorCode" description="" lineageId="4" precision="0" scale="0" length="0" dataType="i4" codePage="0" sortKeyPosition="0" comparisonFlags="0" specialFlags="1" errorOrTruncationOperation="" errorRowDisposition="NotUsed" truncationRowDisposition="NotUsed" externalMetadataColumnId="0" mappedColumnId="0"/>
<outputColumn id="5" name="ErrorColumn" description="" lineageId="5" precision="0" scale="0" length="0" dataType="i4" codePage="0" sortKeyPosition="0" comparisonFlags="0" specialFlags="2" errorOrTruncationOperation="" errorRowDisposition="NotUsed" truncationRowDisposition="NotUsed" externalMetadataColumnId="0" mappedColumnId="0"/></outputColumns><externalMetadataColumns isUsed="False"/></output>
</outputs>
</component>
<component id="9" name="OLE DB Destination" componentClassID="{5A0B62E8-D91D-49F5-94A5-7BE58DE508F0}" description="OLE DB Destination" localeId="-1" usesDispositions="true" validateExternalMetadata="True" version="4" pipelineVersion="0" contactInfo="OLE DB Destination;Microsoft Corporation; Microsoft SqlServer v10; (C) Microsoft Corporation; All Rights Reserved; http://www.microsoft.com/sql/support;4">
<properties>
<property id="10" name="CommandTimeout" dataType="System.Int32" state="default" isArray="false" description="The number of seconds before a command times out.  A value of 0 indicates an infinite time-out." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">0</property>
<property id="11" name="OpenRowset" dataType="System.String" state="default" isArray="false" description="Specifies the name of the database object used to open a rowset." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">[dbo].[Mobile_PhoneMapping]</property>
<property id="12" name="OpenRowsetVariable" dataType="System.String" state="default" isArray="false" description="Specifies the variable that contains the name of the database object used to open a rowset." typeConverter="" UITypeEditor="" containsID="false" expressionType="None"></property>
<property id="13" name="SqlCommand" dataType="System.String" state="default" isArray="false" description="The SQL command to be executed." typeConverter="" UITypeEditor="Microsoft.DataTransformationServices.Controls.ModalMultilineStringEditor, Microsoft.DataTransformationServices.Controls, Version=10.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" containsID="false" expressionType="None"></property>
<property id="14" name="DefaultCodePage" dataType="System.Int32" state="default" isArray="false" description="Specifies the column code page to use when code page information is unavailable from the data source." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">1252</property>
<property id="15" name="AlwaysUseDefaultCodePage" dataType="System.Boolean" state="default" isArray="false" description="Forces the use of the DefaultCodePage property value when describing character data." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="16" name="AccessMode" dataType="System.Int32" state="default" isArray="false" description="Specifies the mode used to access the database." typeConverter="AccessMode" UITypeEditor="" containsID="false" expressionType="None">3</property>
<property id="18" name="FastLoadKeepIdentity" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the values supplied for identity columns will be copied to the destination. If false, values for identity columns will be auto-generated at the destination. Applies only if fast load is turned on." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="19" name="FastLoadKeepNulls" dataType="System.Boolean" state="default" isArray="false" description="Indicates whether the columns containing null will have null inserted in the destination. If false, columns containing null will have their default values inserted at the destination. Applies only if fast load is turned on." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">false</property>
<property id="20" name="FastLoadOptions" dataType="System.String" state="default" isArray="false" description="Specifies options to be used with fast load.  Applies only if fast load is turned on." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">TABLOCK,CHECK_CONSTRAINTS</property>
<property id="21" name="FastLoadMaxInsertCommitSize" dataType="System.Int32" state="default" isArray="false" description="Specifies when commits are issued during data insertion.  A value of 0 specifies that one commit will be issued at the end of data insertion.  Applies only if fast load is turned on." typeConverter="" UITypeEditor="" containsID="false" expressionType="None">2147483647</property></properties>
<connections>
<connection id="17" name="OleDbConnection" description="The OLE DB runtime connection used to access the database." connectionManagerID="{223A17EA-3E15-41DA-90A7-BC25775D455D}"/></connections>
<inputs>
<input id="22" name="OLE DB Destination Input" description="" hasSideEffects="true" dangling="false" errorOrTruncationOperation="Insert" errorRowDisposition="FailComponent" truncationRowDisposition="NotUsed"><inputColumns>
<inputColumn id="110" name="" description="" lineageId="40" usageType="readOnly" errorOrTruncationOperation="" errorRowDisposition="NotUsed" truncationRowDisposition="NotUsed" externalMetadataColumnId="89" mappedColumnId="0"/>
<inputColumn id="111" name="" description="" lineageId="48" usageType="readOnly" errorOrTruncationOperation="" errorRowDisposition="NotUsed" truncationRowDisposition="NotUsed" externalMetadataColumnId="88" mappedColumnId="0"/>
<inputColumn id="112" name="" description="" lineageId="60" usageType="readOnly" errorOrTruncationOperation="" errorRowDisposition="NotUsed" truncationRowDisposition="NotUsed" externalMetadataColumnId="91" mappedColumnId="0"/>
<inputColumn id="113" name="" description="" lineageId="64" usageType="readOnly" errorOrTruncationOperation="" errorRowDisposition="NotUsed" truncationRowDisposition="NotUsed" externalMetadataColumnId="95" mappedColumnId="0"/>
<inputColumn id="114" name="" description="" lineageId="68" usageType="readOnly" errorOrTruncationOperation="" errorRowDisposition="NotUsed" truncationRowDisposition="NotUsed" externalMetadataColumnId="90" mappedColumnId="0"/>
</inputColumns><externalMetadataColumns isUsed="True">
<externalMetadataColumn id="88" name="Number" description="" precision="0" scale="0" length="255" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="89" name="Name" description="" precision="0" scale="0" length="255" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="90" name="Location" description="" precision="0" scale="0" length="255" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="91" name="Group" description="" precision="0" scale="0" length="255" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="92" name="Device Type" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="93" name="Device Usage" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="94" name="Source" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="95" name="Property ID" description="" precision="0" scale="0" length="255" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="96" name="ContractEnd" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="97" name="EmployeeID" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="98" name="DepartmentCode" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="99" name="PropertyCode" description="" precision="0" scale="0" length="50" dataType="str" codePage="1252" mappedColumnId="0"/>
<externalMetadataColumn id="100" name="EmpKey" description="" precision="0" scale="0" length="0" dataType="i4" codePage="0" mappedColumnId="0"/>
<externalMetadataColumn id="101" name="HR_EmployeeID" description="" precision="0" scale="0" length="0" dataType="i4" codePage="0" mappedColumnId="0"/>
<externalMetadataColumn id="102" name="ElementKey" description="" precision="0" scale="0" length="0" dataType="i4" codePage="0" mappedColumnId="0"/>
<externalMetadataColumn id="103" name="MgrKey" description="" precision="0" scale="0" length="0" dataType="i4" codePage="0" mappedColumnId="0"/>
<externalMetadataColumn id="104" name="StageID" description="" precision="0" scale="0" length="0" dataType="i4" codePage="0" mappedColumnId="0"/>
<externalMetadataColumn id="105" name="LoadID" description="" precision="0" scale="0" length="0" dataType="i4" codePage="0" mappedColumnId="0"/>
<externalMetadataColumn id="106" name="DWPackageGUID" description="" precision="0" scale="0" length="38" dataType="wstr" codePage="0" mappedColumnId="0"/>
<externalMetadataColumn id="107" name="DWExecutionGUID" description="" precision="0" scale="0" length="38" dataType="wstr" codePage="0" mappedColumnId="0"/>
<externalMetadataColumn id="108" name="DWSourceFileInstance" description="" precision="0" scale="0" length="2000" dataType="wstr" codePage="0" mappedColumnId="0"/>
<externalMetadataColumn id="109" name="DWInsertedBy" description="" precision="0" scale="0" length="50" dataType="wstr" codePage="0" mappedColumnId="0"/></externalMetadataColumns></input>
</inputs>
<outputs>
<output id="23" name="OLE DB Destination Error Output" description="" exclusionGroup="1" synchronousInputId="22" deleteOutputOnPathDetached="false" hasSideEffects="false" dangling="false" isErrorOut="true" isSorted="false" errorOrTruncationOperation="" errorRowDisposition="NotUsed" truncationRowDisposition="NotUsed"><outputColumns>
<outputColumn id="24" name="ErrorCode" description="" lineageId="24" precision="0" scale="0" length="0" dataType="i4" codePage="0" sortKeyPosition="0" comparisonFlags="0" specialFlags="1" errorOrTruncationOperation="" errorRowDisposition="NotUsed" truncationRowDisposition="NotUsed" externalMetadataColumnId="0" mappedColumnId="0"/>
<outputColumn id="25" name="ErrorColumn" description="" lineageId="25" precision="0" scale="0" length="0" dataType="i4" codePage="0" sortKeyPosition="0" comparisonFlags="0" specialFlags="2" errorOrTruncationOperation="" errorRowDisposition="NotUsed" truncationRowDisposition="NotUsed" externalMetadataColumnId="0" mappedColumnId="0"/></outputColumns><externalMetadataColumns isUsed="False"/></output>
</outputs>
</component>
</components>
<paths>
<path id="26" name="Flat File Source Output" description="" startId="2" endId="22"/>
</paths></pipeline></DTS:ObjectData></DTS:Executable>]]>		
</xsl:template>
	<xsl:template name="CreatePackage"><![CDATA[<?xml version="1.0"?><DTS:Executable xmlns:DTS="www.microsoft.com/SqlServer/Dts" DTS:ExecutableType="SSIS.Package.2">
<DTS:Property DTS:Name="PackageFormatVersion">3</DTS:Property>
<DTS:Property DTS:Name="VersionComments"></DTS:Property>
<DTS:Property DTS:Name="CreatorName">DLR\jcates</DTS:Property>
<DTS:Property DTS:Name="CreatorComputerName">DFW10-BI-DEV</DTS:Property>
<DTS:Property DTS:Name="CreationDate" DTS:DataType="7">3/16/2010 2:06:15 PM</DTS:Property>
<DTS:Property DTS:Name="PackageType">5</DTS:Property>
<DTS:Property DTS:Name="ProtectionLevel">1</DTS:Property>
<DTS:Property DTS:Name="MaxConcurrentExecutables">-1</DTS:Property>
<DTS:Property DTS:Name="PackagePriorityClass">0</DTS:Property>
<DTS:Property DTS:Name="VersionMajor">1</DTS:Property>
<DTS:Property DTS:Name="VersionMinor">0</DTS:Property>
<DTS:Property DTS:Name="VersionBuild">1</DTS:Property>
<DTS:Property DTS:Name="VersionGUID">{FE251D5C-361D-419A-A278-A7DD92F2E500}</DTS:Property>
<DTS:Property DTS:Name="EnableConfig">0</DTS:Property>
<DTS:Property DTS:Name="CheckpointFileName"></DTS:Property>
<DTS:Property DTS:Name="SaveCheckpoints">0</DTS:Property>
<DTS:Property DTS:Name="CheckpointUsage">0</DTS:Property>
<DTS:Property DTS:Name="SuppressConfigurationWarnings">0</DTS:Property>
<DTS:Variable>
<DTS:Property DTS:Name="Expression"></DTS:Property>
<DTS:Property DTS:Name="EvaluateAsExpression">0</DTS:Property>
<DTS:Property DTS:Name="Namespace">User</DTS:Property>
<DTS:Property DTS:Name="ReadOnly">0</DTS:Property>
<DTS:Property DTS:Name="RaiseChangedEvent">0</DTS:Property>
<DTS:Property DTS:Name="IncludeInDebugDump">2345</DTS:Property><DTS:VariableValue DTS:DataType="8"></DTS:VariableValue>
<DTS:Property DTS:Name="ObjectName">InputFIle</DTS:Property>
<DTS:Property DTS:Name="Description"></DTS:Property>
<DTS:Property DTS:Name="CreationName"></DTS:Property></DTS:Variable>]]><xsl:for-each select="Sources/Source[position()=2]"><![CDATA[
<DTS:ConnectionManager>
<DTS:Property DTS:Name="DelayValidation">0</DTS:Property>
<DTS:Property DTS:Name="ObjectName">Cellular_Public_Source</DTS:Property>
<DTS:Property DTS:Name="DTSID">]]><xsl:value-of select="hs:Guid('Cellular_Public_Source')"/><![CDATA[</DTS:Property>
<DTS:Property DTS:Name="Description"></DTS:Property>
<DTS:Property DTS:Name="CreationName">FLATFILE</DTS:Property><DTS:PropertyExpression DTS:Name="ConnectionString">@[User::InputFIle]</DTS:PropertyExpression>
<DTS:ObjectData><DTS:ConnectionManager>
<DTS:Property DTS:Name="FileUsageType">0</DTS:Property>
<DTS:Property DTS:Name="Format">Delimited</DTS:Property>
<DTS:Property DTS:Name="LocaleID">1033</DTS:Property>
<DTS:Property DTS:Name="Unicode">0</DTS:Property>
<DTS:Property DTS:Name="HeaderRowsToSkip">0</DTS:Property>
<DTS:Property DTS:Name="HeaderRowDelimiter" xml:space="preserve">_x000D__x000A_</DTS:Property>
<DTS:Property DTS:Name="ColumnNamesInFirstDataRow">-1</DTS:Property>
<DTS:Property DTS:Name="RowDelimiter" xml:space="preserve"></DTS:Property>
<DTS:Property DTS:Name="DataRowsToSkip">0</DTS:Property>
<DTS:Property DTS:Name="TextQualifier">"</DTS:Property>
<DTS:Property DTS:Name="CodePage">1252</DTS:Property>]]><xsl:for-each select="Column"><![CDATA[
<DTS:FlatFileColumn>
<DTS:Property DTS:Name="ColumnType">Delimited</DTS:Property>
<DTS:Property DTS:Name="ColumnDelimiter" xml:space="preserve">]]><xsl:choose>
	<xsl:when test="position() &lt; count(../Column)">_x002C_</xsl:when>
	<xsl:otherwise>_x000D__x000A_</xsl:otherwise>
</xsl:choose><![CDATA[</DTS:Property>
<DTS:Property DTS:Name="ColumnWidth">0</DTS:Property>
<DTS:Property DTS:Name="MaximumWidth">50</DTS:Property>
<DTS:Property DTS:Name="DataType">129</DTS:Property>
<DTS:Property DTS:Name="DataPrecision">0</DTS:Property>
<DTS:Property DTS:Name="DataScale">0</DTS:Property>
<DTS:Property DTS:Name="TextQualified">-1</DTS:Property>
<DTS:Property DTS:Name="ObjectName">]]><xsl:value-of select="@name"/><![CDATA[</DTS:Property>
<DTS:Property DTS:Name="Description"></DTS:Property>
<DTS:Property DTS:Name="CreationName"></DTS:Property></DTS:FlatFileColumn>]]></xsl:for-each><![CDATA[
<DTS:Property DTS:Name="ConnectionString">c:\jbc\Mobile\Cellular_Public.csv</DTS:Property></DTS:ConnectionManager></DTS:ObjectData>
</DTS:ConnectionManager>]]></xsl:for-each><![CDATA[
<DTS:ConnectionManager>
<DTS:Property DTS:Name="DelayValidation">0</DTS:Property>
<DTS:Property DTS:Name="ObjectName">Staging</DTS:Property>
<DTS:Property DTS:Name="DTSID">{223A17EA-3E15-41DA-90A7-BC25775D455D}</DTS:Property>
<DTS:Property DTS:Name="Description"></DTS:Property>
<DTS:Property DTS:Name="CreationName">OLEDB</DTS:Property><DTS:ObjectData><DTS:ConnectionManager>
<DTS:Property DTS:Name="Retain">0</DTS:Property>
<DTS:Property DTS:Name="ConnectionString">Data Source=dfw10-bi-dev;Initial Catalog=DWStaging;Provider=SQLNCLI10.1;Integrated Security=SSPI;Application Name=SSIS-Package1-{223A17EA-3E15-41DA-90A7-BC25775D455D}dfw10-bi-dev.DWStaging;Auto Translate=False;</DTS:Property></DTS:ConnectionManager></DTS:ObjectData></DTS:ConnectionManager>
<DTS:Property DTS:Name="LastModifiedProductVersion">10.0.2531.0</DTS:Property>
<DTS:Property DTS:Name="ForceExecValue">0</DTS:Property>
<DTS:Property DTS:Name="ExecValue" DTS:DataType="3">0</DTS:Property>
<DTS:Property DTS:Name="ForceExecutionResult">-1</DTS:Property>
<DTS:Property DTS:Name="Disabled">0</DTS:Property>
<DTS:Property DTS:Name="FailPackageOnFailure">0</DTS:Property>
<DTS:Property DTS:Name="FailParentOnFailure">0</DTS:Property>
<DTS:Property DTS:Name="MaxErrorCount">1</DTS:Property>
<DTS:Property DTS:Name="ISOLevel">1048576</DTS:Property>
<DTS:Property DTS:Name="LocaleID">1033</DTS:Property>
<DTS:Property DTS:Name="TransactionOption">1</DTS:Property>
<DTS:Property DTS:Name="DelayValidation">0</DTS:Property>
<DTS:LoggingOptions>
<DTS:Property DTS:Name="LoggingMode">0</DTS:Property>
<DTS:Property DTS:Name="FilterKind">1</DTS:Property>
<DTS:Property DTS:Name="EventFilter" DTS:DataType="8"></DTS:Property></DTS:LoggingOptions>]]><xsl:call-template name="Pipeline"><xsl:with-param name="ConnectionName" select="'Cellular_Public_Source'"/></xsl:call-template><![CDATA[
<DTS:Property DTS:Name="ObjectName">Package1</DTS:Property>
<DTS:Property DTS:Name="Description"></DTS:Property>
<DTS:Property DTS:Name="CreationName">SSIS.Package.2</DTS:Property>
<DTS:Property DTS:Name="DisableEventHandlers">0</DTS:Property></DTS:Executable>
	]]></xsl:template>
	<xsl:template name="CreatePackage_OLD"><![CDATA[<?xml version="1.0"?>
		<DTS:Executable xmlns:DTS="www.microsoft.com/SqlServer/Dts" DTS:ExecutableType="SSIS.Package.2">
			<DTS:Property DTS:Name="PackageFormatVersion">3</DTS:Property>
			<DTS:Property DTS:Name="VersionComments"></DTS:Property>
			<DTS:Property DTS:Name="CreatorName">DLR\jcates</DTS:Property>
			<DTS:Property DTS:Name="CreatorComputerName">DFW10-BI-DEV</DTS:Property>
			<DTS:Property DTS:Name="CreationDate" DTS:DataType="7">3/16/2010 2:06:15 PM</DTS:Property>
			<DTS:Property DTS:Name="PackageType">5</DTS:Property>
			<DTS:Property DTS:Name="ProtectionLevel">1</DTS:Property>
			<DTS:Property DTS:Name="MaxConcurrentExecutables">-1</DTS:Property>
			<DTS:Property DTS:Name="PackagePriorityClass">0</DTS:Property>
			<DTS:Property DTS:Name="VersionMajor">1</DTS:Property>
			<DTS:Property DTS:Name="VersionMinor">0</DTS:Property>
			<DTS:Property DTS:Name="VersionBuild">1</DTS:Property>
			<DTS:Property DTS:Name="VersionGUID">{1A90BBE5-A65A-4272-B84E-474F6FF64A02}</DTS:Property>
			<DTS:Property DTS:Name="EnableConfig">0</DTS:Property>
			<DTS:Property DTS:Name="CheckpointFileName"></DTS:Property>
			<DTS:Property DTS:Name="SaveCheckpoints">0</DTS:Property>
			<DTS:Property DTS:Name="CheckpointUsage">0</DTS:Property>
			<DTS:Property DTS:Name="SuppressConfigurationWarnings">0</DTS:Property>
	]]>
		<xsl:for-each select="Sources/Source[position()=0]">
			<![CDATA[
			<DTS:ConnectionManager>
				<DTS:Property DTS:Name="DelayValidation">0</DTS:Property>
				<DTS:Property DTS:Name="ObjectName">]]><xsl:value-of select="@name"/><![CDATA[</DTS:Property>
				<DTS:Property DTS:Name="Description"></DTS:Property>
				<DTS:Property DTS:Name="DTSID">{123E33B1-B596-4E60-92DC-D0B2A6931A09}</DTS:Property>
				<DTS:Property DTS:Name="CreationName">FLATFILE</DTS:Property>
				<DTS:ObjectData>
					<DTS:ConnectionManager>
						<DTS:Property DTS:Name="FileUsageType">0</DTS:Property>
						<DTS:Property DTS:Name="Format">Delimited</DTS:Property>
						<DTS:Property DTS:Name="LocaleID">1033</DTS:Property>
						<DTS:Property DTS:Name="Unicode">0</DTS:Property>
						<DTS:Property DTS:Name="HeaderRowsToSkip">0</DTS:Property>
						<DTS:Property DTS:Name="HeaderRowDelimiter" xml:space="preserve">_x000D__x000A_</DTS:Property>
						<DTS:Property DTS:Name="ColumnNamesInFirstDataRow">-1</DTS:Property>
						<DTS:Property DTS:Name="RowDelimiter" xml:space="preserve"></DTS:Property>
						<DTS:Property DTS:Name="DataRowsToSkip">0</DTS:Property>
						<DTS:Property DTS:Name="TextQualifier">"</DTS:Property>
						<DTS:Property DTS:Name="CodePage">1252</DTS:Property>
						]]>
						<xsl:for-each select="Column[position()=0]">
							<![CDATA[
							<DTS:FlatFileColumn>
								<DTS:Property DTS:Name="ColumnType">Delimited</DTS:Property>
								<DTS:Property DTS:Name="ColumnDelimiter" xml:space="preserve">_x002C_</DTS:Property>
								<DTS:Property DTS:Name="ColumnWidth">0</DTS:Property>
								<DTS:Property DTS:Name="MaximumWidth">50</DTS:Property>
								<DTS:Property DTS:Name="DataType">129</DTS:Property>
								<DTS:Property DTS:Name="DataPrecision">0</DTS:Property>
								<DTS:Property DTS:Name="DataScale">0</DTS:Property>
								<DTS:Property DTS:Name="TextQualified">-1</DTS:Property>
								<DTS:Property DTS:Name="ObjectName">]]><xsl:value-of select="@name"/><![CDATA[</DTS:Property>
								<DTS:Property DTS:Name="DTSID">{5483C249-8EE2-458B-B4E4-7CF1E8D95437}</DTS:Property>
								<DTS:Property DTS:Name="Description"></DTS:Property>
								<DTS:Property DTS:Name="CreationName"></DTS:Property>
							</DTS:FlatFileColumn>
							]]>
						</xsl:for-each>
						<![CDATA[
						<DTS:Property DTS:Name="ConnectionString">]]><xsl:value-of select="concat('c:\jbc\mobile\',@table)"/><![CDATA[[</DTS:Property>
					</DTS:ConnectionManager>
				</DTS:ObjectData>
			</DTS:ConnectionManager>						
			]]>
		</xsl:for-each>
	<![CDATA[
			<DTS:Property DTS:Name="LastModifiedProductVersion">10.0.2531.0</DTS:Property>
			<DTS:Property DTS:Name="ForceExecValue">0</DTS:Property>
			<DTS:Property DTS:Name="ExecValue" DTS:DataType="3">0</DTS:Property>
			<DTS:Property DTS:Name="ForceExecutionResult">-1</DTS:Property>
			<DTS:Property DTS:Name="Disabled">0</DTS:Property>
			<DTS:Property DTS:Name="FailPackageOnFailure">0</DTS:Property>
			<DTS:Property DTS:Name="FailParentOnFailure">0</DTS:Property>
			<DTS:Property DTS:Name="MaxErrorCount">1</DTS:Property>
			<DTS:Property DTS:Name="ISOLevel">1048576</DTS:Property>
			<DTS:Property DTS:Name="LocaleID">1033</DTS:Property>
			<DTS:Property DTS:Name="TransactionOption">1</DTS:Property>
			<DTS:Property DTS:Name="DelayValidation">0</DTS:Property>
			<DTS:LoggingOptions>
				<DTS:Property DTS:Name="LoggingMode">0</DTS:Property>
				<DTS:Property DTS:Name="FilterKind">1</DTS:Property>
				<DTS:Property DTS:Name="EventFilter" DTS:DataType="8"></DTS:Property>
			</DTS:LoggingOptions>
			<DTS:Property DTS:Name="ObjectName">Package1</DTS:Property>
			<DTS:Property DTS:Name="Description"></DTS:Property>
			<DTS:Property DTS:Name="CreationName">SSIS.Package.2</DTS:Property>
			<DTS:Property DTS:Name="DisableEventHandlers">0</DTS:Property>
		</DTS:Executable>
		]]>
	</xsl:template>
</xsl:stylesheet>
