<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:ns uri="urn:nguyen:treninkovyPlan" prefix="t"/>

    <sch:pattern>
        <sch:title>Date check of start and end</sch:title>

        <sch:rule context="t:plan">
            <sch:assert test="t:start &lt; t:end"> Date start of plan must be before date end </sch:assert>

            <sch:assert test="t:start &lt;= current-date()"> Date start can't be in the future. </sch:assert>

        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:title>Check series and reps</sch:title>

        <sch:rule context="t:warmUp">
            <sch:assert test="xs:integer(t:series) &lt;= xs:integer(t:reps)"> Number of series must lower than number of reps
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="t:topSet">
            <sch:assert test="xs:integer(t:series) &lt;= xs:integer(t:reps)"> Number of series must lower than number of reps
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="t:backOffSet">
            <sch:assert test="xs:integer(t:series) &lt;= xs:integer(t:reps)"> Number of series must lower than number of reps
            </sch:assert>
        </sch:rule>
        
    </sch:pattern>

</sch:schema>
