<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xpath-default-namespace="urn:nguyen:treninkovyPlan" version="2.0">


    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:param name="barva" select="'black'"/>

    <xsl:variable name="restDay">
        <fo:block font-size="25px" font-weight="bold" margin-top="0.5cm" margin-bottom="0.5cm">Rest
            day</fo:block>
    </xsl:variable>

    <xsl:template match="/">
        <fo:root language="cs">
            <fo:layout-master-set>
                <fo:simple-page-master margin-bottom="1.5cm" margin-left="1.5cm"
                    margin-right="1.5cm" margin-top="1.5cm" master-name="first" page-height="29.7cm"
                    page-width="21cm" margin="1cm">
                    <fo:region-body margin="1cm"/>
                    <fo:region-before extent="0.4cm"/>
                    <fo:region-after extent="0.4cm"/>
                </fo:simple-page-master>
                <fo:simple-page-master margin-bottom="1.5cm" margin-left="1.5cm"
                    margin-right="1.5cm" margin-top="1.5cm" master-name="rest" page-height="29.7cm"
                    page-width="21cm" margin="1cm">
                    <fo:region-body margin="1cm"/>
                    <fo:region-before extent="0.4cm"/>
                    <fo:region-after extent="0.4cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="first">

                <fo:static-content flow-name="xsl-region-before">
                    <fo:block text-align="right" color="red"> Semestrální práce 4IZ238, Kevin Nguyen
                    </fo:block>
                </fo:static-content>

                <fo:flow flow-name="xsl-region-body">
                    <fo:block/>
                    <fo:block font-size="30px" font-weight="bold" space-before="10cm"
                        text-align="center"> Semestrální práce 4IZ238 </fo:block>
                    <fo:block font-size="40px" font-weight="bold" space-before="1cm"
                        text-align="center"> List of training plans </fo:block>
                    <fo:block font-size="20px" font-weight="bold" space-before="1cm"
                        text-align="center"> Kevin Nguyen </fo:block>
                </fo:flow>
            </fo:page-sequence>


            <fo:page-sequence master-reference="rest" font-family="Arial">

                <fo:static-content flow-name="xsl-region-before">
                    <fo:block text-align="right" color="red"> Semestrální práce 4IZ238, Kevin Nguyen
                    </fo:block>
                </fo:static-content>

                <fo:static-content flow-name="xsl-region-after">
                    <fo:block text-align="center"> Page <fo:page-number/>
                    </fo:block>
                </fo:static-content>

                <fo:flow flow-name="xsl-region-body">
                    <fo:block-container width="15cm">
                        <fo:block break-before="page" font-weight="bold" font-size="30px"
                            space-after="1cm"> Content </fo:block>
                        <fo:block>
                            <xsl:for-each select="trainingPlan/plan">


                                <fo:block text-align-last="justify">
                                    <fo:basic-link internal-destination="{generate-id(.)}">
                                        <xsl:value-of select="name"/>
                                    </fo:basic-link>
                                    <fo:leader leader-pattern="dots"/>
                                    <fo:page-number-citation ref-id="{generate-id(.)}"/>
                                </fo:block>
                            </xsl:for-each>
                        </fo:block>
                    </fo:block-container>

                    <fo:block-container>
                        <xsl:apply-templates select="trainingPlan/plan"> </xsl:apply-templates>
                    </fo:block-container>

                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="exercisePhoto">
        <fo:external-graphic src="url('{@src}')" content-width="150px"/>
    </xsl:template>

    <xsl:template match="musclesPhoto">
        <fo:external-graphic src="url('{@src}')" content-width="10%"/>
    </xsl:template>

    <xsl:template match="cardio/exercisePhoto" mode="cardioPhoto">
        <fo:external-graphic src="url('{@src}')" content-width="150px"/>
    </xsl:template>


    <xsl:template match="musclesTargetedPhoto" mode="musclesTargetedPhoto">
        <fo:external-graphic src="url('{@src}')" content-width="330px"/>
    </xsl:template>

    <xsl:template match="plan">
        <fo:block id="{generate-id(.)}" break-before="page" font-weight="bold" font-size="35px" margin-bottom="0.2cm" color="blue">
            <xsl:value-of select="name"/>
        </fo:block>
        <fo:table border="0.06cm solid black">
            <fo:table-body>
                <fo:table-row border="0.03cm solid black">
                    <fo:table-cell border="0.03cm solid black">
                        <fo:block font-weight="bold">Start</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:apply-templates select="start" mode="date"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="0.03cm solid black">
                    <fo:table-cell border="0.03cm solid black">
                        <fo:block font-weight="bold">End</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:apply-templates select="end" mode="date"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
        <fo:block>
            <xsl:choose>
                <xsl:when test="@pid = 1">
                    <xsl:apply-templates select="../person[@oid = 1]" mode="personInfo"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="../person[@oid = 2]" mode="personInfo"/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:block>
        <fo:block>
            <xsl:apply-templates select="day" mode="exercise_table"/>
        </fo:block>
    </xsl:template>


    <xsl:template match="person" mode="personInfo">
        <fo:block font-size="25px" font-weight="bold" margin-top="0.5cm" margin-bottom="0.5cm"
            >Person ID<xsl:text> </xsl:text><xsl:value-of select="@oid"/></fo:block>
        <fo:table border="0.06cm solid black">
            <fo:table-body>
                <fo:table-row border="0.03cm solid black">
                    <fo:table-cell border="0.03cm solid black">
                        <fo:block font-weight="bold">Forname</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="forename"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="0.03cm solid black">
                    <fo:table-cell border="0.03cm solid black">
                        <fo:block font-weight="bold">Surname</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="surname"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="0.03cm solid black">
                    <fo:table-cell border="0.03cm solid black">
                        <fo:block font-weight="bold">Age</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="age"/> years old </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="0.03cm solid black">
                    <fo:table-cell border="0.03cm solid black">
                        <fo:block font-weight="bold">Height</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="height"/> cm </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="0.03cm solid black">
                    <fo:table-cell border="0.03cm solid black">
                        <fo:block font-weight="bold">Weight</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="weight"/> kg </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="0.03cm solid black">
                    <fo:table-cell border="0.03cm solid black">
                        <fo:block font-weight="bold">Goal</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="goal"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="0.03cm solid black">
                    <fo:table-cell border="0.03cm solid black">
                        <fo:block font-weight="bold">Profession</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="profession"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="0.03cm solid black">
                    <fo:table-cell border="0.03cm solid black">
                        <fo:block font-weight="bold">Frequency (in a week)</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="frequencyInAWeek"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="0.03cm solid black">
                    <fo:table-cell border="0.03cm solid black">
                        <fo:block font-weight="bold">Experience</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="experience"/> year </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="0.03cm solid black">
                    <fo:table-cell border="0.03cm solid black">
                        <fo:block font-weight="bold">Given Plan</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="givenPlan"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>








    <xsl:template match="day" mode="exercise_table">
        <fo:block break-after="page" margin-top="0.5cm" margin-bottom="0.2cm">
            <fo:block font-weight="bold" font-size="30px"> Day<xsl:text> </xsl:text><xsl:value-of
                    select="@date/format-date(xs:date(.), '[D01].[M01].[Y]')"/>
            </fo:block>

            <xsl:choose>
                <xsl:when test="rest">
                    <xsl:copy-of select="($restDay)"/>
                </xsl:when>
                <xsl:otherwise>
                    <fo:block font-size="25px" font-weight="bold" margin-top="0.5cm"
                        margin-bottom="0.5cm"> Split <xsl:text> </xsl:text>
                        <xsl:value-of select="training/@split"/>
                    </fo:block>
                    <fo:table border="0.06cm solid black" font-size="17px">
                        <fo:table-column column-width="3cm"/>
                        <fo:table-column column-width="3.3cm"/>
                        <fo:table-column column-width="3cm"/>
                        <fo:table-column column-width="2cm"/>
                        <fo:table-column column-width="1.5cm"/>
                        <fo:table-column column-width="1.5cm"/>
                        <fo:table-column column-width="1.6cm"/>
                        <fo:table-header>
                            <fo:table-row border="0.03cm solid black">
                                <fo:table-cell border="0.03cm solid black" text-align="center">
                                    <fo:block font-weight="bold">Exercise</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="0.03cm solid black" text-align="center">
                                    <fo:block font-weight="bold">Photo</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="0.03cm solid black" text-align="center">
                                    <fo:block font-weight="bold">Targeted Muscles</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="0.03cm solid black" text-align="center">
                                    <fo:block font-weight="bold">Photo</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="0.03cm solid black" text-align="center">
                                    <fo:block font-weight="bold">Warm Up (series/reps)</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="0.03cm solid black" text-align="center">
                                    <fo:block font-weight="bold">Top Set (series/reps)</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="0.03cm solid black" text-align="center">
                                    <fo:block font-weight="bold">Back Off Set
                                        (series/reps)</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body>
                            <xsl:for-each select="training/exercise">
                                <xsl:sort select="@cid" data-type="number" order="ascending"/>
                                <fo:table-row>
                                    <fo:table-cell padding-top="0.3cm" text-align="center"
                                        border="0.03cm solid black">
                                        <fo:block>
                                            <xsl:value-of select="name"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell text-align="center" border="0.03cm solid black">
                                        <fo:block>
                                            <xsl:apply-templates select="exercisePhoto"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-top="0.3cm" text-align="center" border="0.03cm solid black">
                                        <fo:block>
                                            <xsl:value-of select="muscles"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell background-color="{$barva}" text-align="center" border="0.03cm solid black">
                                        <fo:block>
                                            <xsl:apply-templates select="musclesPhoto"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-top="0.3cm" text-align="center" border="0.03cm solid black">
                                        <fo:block>
                                            <xsl:value-of select="warmUp/series"/>
                                            <xsl:text>    </xsl:text>
                                            <xsl:value-of select="warmUp/reps"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-top="0.3cm" text-align="center" border="0.03cm solid black">
                                        <fo:block>
                                            <xsl:value-of select="topSet/series"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="topSet/reps"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-top="0.3cm" text-align="center" border="0.03cm solid black">
                                        <fo:block>
                                            <xsl:value-of select="backOffSet/series"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="backOffSet/reps"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                        </fo:table-body>
                    </fo:table>

                    <fo:block font-size="25px" font-weight="bold" margin-top="0.5cm"
                        margin-bottom="0.5cm">Cardio</fo:block>
                    <fo:table border="0.06cm solid black" font-size="17px">
                        <fo:table-column column-width="3.2cm"/>
                        <fo:table-column column-width="3.2cm"/>
                        <fo:table-column column-width="3.2cm"/>
                        <fo:table-column column-width="3.2cm"/>
                        <fo:table-column column-width="3.2cm"/>
                        <fo:table-header>
                            <fo:table-row border="0.03cm solid black">
                                <fo:table-cell border="0.03cm solid black" text-align="center">
                                    <fo:block font-weight="bold">Exercise</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="0.03cm solid black" text-align="center">
                                    <fo:block font-weight="bold">Photo</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="0.03cm solid black" text-align="center">
                                    <fo:block font-weight="bold">Period</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="0.03cm solid black" text-align="center">
                                    <fo:block font-weight="bold">Speed</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="0.03cm solid black" text-align="center">
                                    <fo:block font-weight="bold">Incline</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body>
                            <xsl:for-each select="training/cardio">
                                <fo:table-row>
                                    <fo:table-cell padding-top="0.3cm" text-align="center"
                                        border="0.03cm solid black">
                                        <fo:block>
                                            <xsl:value-of select="name"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell text-align="center" border="0.03cm solid black">
                                        <fo:block>
                                            <xsl:apply-templates select="exercisePhoto"
                                                mode="cardioPhoto"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-top="0.3cm" text-align="center"
                                        border="0.03cm solid black">
                                        <fo:block>
                                            <xsl:value-of select="period"/> minutes </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-top="0.3cm" text-align="center"
                                        border="0.03cm solid black">
                                        <fo:block>
                                            <xsl:value-of select="speed"/> km/h </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-top="0.3cm" text-align="center"
                                        border="0.03cm solid black">
                                        <fo:block>
                                            <xsl:value-of select="incline"/> % </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                        </fo:table-body>
                    </fo:table>

                    <fo:block font-size="25px" font-weight="bold" margin-top="0.5cm"
                        margin-bottom="0.5cm">Summary</fo:block>
                    <fo:table border="0.06cm solid black" font-size="17px">
                        <fo:table-column column-width="4cm"/>
                        <fo:table-column column-width="2cm"/>
                        <fo:table-column column-width="3cm"/>
                        <fo:table-column column-width="7cm"/>
                        <fo:table-header>
                            <fo:table-row border="0.03cm solid black">
                                <fo:table-cell border="0.03cm solid black" text-align="center">
                                    <fo:block font-weight="bold">Estimated Time</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="0.03cm solid black" text-align="center">
                                    <fo:block font-weight="bold">Number Of Exercises</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="0.03cm solid black" text-align="center">
                                    <fo:block font-weight="bold">Targeted Muscles</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="0.03cm solid black" text-align="center">
                                    <fo:block font-weight="bold">Photo</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body>
                            <xsl:for-each select="training/summary">
                                <fo:table-row>
                                    <fo:table-cell padding-top="0.3cm" text-align="center"
                                        border="0.03cm solid black">
                                        <fo:block>
                                            <xsl:value-of select="estimatedTime"/> hours </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-top="0.3cm" text-align="center"
                                        border="0.03cm solid black">
                                        <fo:block>
                                            <xsl:value-of select="quantity"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-top="0.3cm" text-align="center"
                                        border="0.03cm solid black">
                                        <fo:block>
                                            <xsl:value-of select="primaryMuscle"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell text-align="center" border="0.03cm solid black">
                                            <fo:block background-color="{$barva}" text-align="center">
                                            <xsl:apply-templates select="musclesTargetedPhoto"
                                                mode="musclesTargetedPhoto"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                        </fo:table-body>
                    </fo:table>

                </xsl:otherwise>
            </xsl:choose>
        </fo:block>
    </xsl:template>























    <xsl:template match="start" mode="date">
        <xsl:value-of select="format-date(xs:date(.), '[D01].[M01].[Y]')"/>
    </xsl:template>

    <xsl:template match="end" mode="date">
        <xsl:value-of select="format-date(xs:date(.), '[D01].[M01].[Y]')"/>
    </xsl:template>
</xsl:stylesheet>
