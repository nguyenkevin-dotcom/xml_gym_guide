<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="urn:nguyen:treninkovyPlan"
    exclude-result-prefixes="xs t" xpath-default-namespace="urn:nguyen:treninkovyPlan" version="2.0">

    <xsl:output method="html" version="5" encoding="UTF-8"/>

    <xsl:output method="html" version="5" name="html5"/>
    
    <xsl:param name="barva" select="'black'"/>
    
    <xsl:variable name="restDay">
        <h3>Rest day</h3>
    </xsl:variable>

    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta name="author" content="Kevin Nguyen"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <link rel="stylesheet" href="treninkovyPlan.css" type="text/css"/>
                <title>Training Plan</title>
            </head>
            <body>
                <xsl:apply-templates/>
                <footer>&#xA9;2024 Kevin Nguyen</footer>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="t:trainingPlan">
        <a href="treninkovyPlan.html">
            <h1>Training Plan</h1>
        </a>

        <xsl:apply-templates select="t:person"/>
        <xsl:apply-templates select="t:plan"/>
    </xsl:template>


    <xsl:template match="t:person">
        <table>
            <tr>
                <td>
                    <h3>Person ID <xsl:value-of select="@oid"/></h3>
                </td>
                <td/>
            </tr>
            <tr>
                <td>Forename</td>
                <td>
                    <xsl:value-of select="t:forename"/>
                </td>
            </tr>
            <tr>
                <td>Surname</td>
                <td>
                    <xsl:value-of select="t:surname"/>
                </td>
            </tr>
            <tr>
                <td>Age</td>
                <td>
                    <xsl:value-of select="t:age"/> years old </td>
            </tr>
            <tr>
                <td>Height</td>
                <td>
                    <xsl:value-of select="t:height"/> cm </td>
            </tr>
            <tr>
                <td>Weight</td>
                <td>
                    <xsl:value-of select="t:weight"/> kg </td>
            </tr>
            <tr>
                <td>Goal</td>
                <td>
                    <xsl:value-of select="t:goal"/>
                </td>
            </tr>
            <tr>
                <td>Profession</td>
                <td>
                    <xsl:value-of select="t:profession"/>
                </td>
            </tr>
            <tr>
                <td>Frequency (in a week)</td>
                <td>
                    <xsl:value-of select="t:frequencyInAWeek"/>
                </td>
            </tr>
            <tr>
                <td>Experience</td>
                <td>
                    <xsl:value-of select="t:experience"/> year </td>
            </tr>
            <tr>
                <td>Given Plan</td>
                <td>
                    <xsl:choose>
                        <xsl:when test="@oid = 1">
                            <xsl:apply-templates select="../t:plan[@pid = 1]/t:name" mode="toc"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="../t:plan[@pid = 2]/t:name" mode="toc"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="t:plan/t:name" mode="toc">
        <a href="{generate-id()}.html">
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="t:exercisePhoto" mode="exercisePhoto">
        <img class="exercise" src="{@src}" alt="{generate-id()}"/>
    </xsl:template>

    <xsl:template match="t:musclesPhoto" mode="musclesPhoto">
        <img class="muscles" src="{@src}" alt="{generate-id()}"/>
    </xsl:template>

    <xsl:template match="t:exercisePhoto" mode="cardioPhoto">
        <img class="cardio" src="{@src}" alt="{generate-id()}"/>
    </xsl:template>

    <xsl:template match="t:musclesTargetedPhoto" mode="musclesTargetedPhoto">
        <img class="summary" src="{@src}" alt="{generate-id()}"/>
    </xsl:template>


    <xsl:template match="t:plan/t:day" mode="exercise_table">

        <h2> Day <xsl:text> </xsl:text>
            <xsl:value-of select="@date/format-date(xs:date(.), '[D01].[M01].[Y]')"/>
        </h2>



        <xsl:choose>
            <xsl:when test="t:rest">
                <xsl:copy-of select="$restDay"/>
            </xsl:when>
            <xsl:otherwise>
                <h3>
                    Split <xsl:text> </xsl:text><xsl:value-of select="t:training/@split"/>
                </h3>

                <table class="roster">
                    <tr>
                        <th>Exercise</th>
                        <th>Photo</th>
                        <th>Targeted Muscles</th>
                        <th>Photo</th>
                        <th>Warm Up <table class="reps">
                                <tr>
                                    <th>Series</th>
                                    <th>Reps</th>
                                </tr>
                            </table>
                        </th>
                        <th>Top Set <table class="reps">
                                <tr>
                                    <th>Series</th>
                                    <th>Reps</th>
                                </tr>
                            </table>
                        </th>
                        <th>Back Off Set <table class="reps">
                                <tr>
                                    <th>Series</th>
                                    <th>Reps</th>
                                </tr>
                            </table></th>
                    </tr>



                    <xsl:for-each select="t:training/t:exercise">
                        <xsl:sort select="@cid" data-type="number" order="ascending"/>
                        <tr>
                            <td>
                                <xsl:value-of select="t:name"/>
                            </td>
                            <td>
                                <xsl:apply-templates select="t:exercisePhoto" mode="exercisePhoto"/>
                            </td>
                            <td>
                                <xsl:value-of select="t:muscles"/>
                            </td>
                            <td bgcolor="{$barva}">
                                <xsl:apply-templates select="t:musclesPhoto" mode="musclesPhoto"/>
                            </td>
                            <td>
                                <table class="reps">
                                    <tr>
                                        <td>
                                            <xsl:value-of select="t:warmUp/t:series"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select="t:warmUp/t:reps"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <table class="reps">
                                    <tr>
                                        <td>
                                            <xsl:value-of select="t:topSet/t:series"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select="t:topSet/t:reps"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <table class="reps">
                                    <tr>
                                        <td>
                                            <xsl:value-of select="t:backOffSet/t:series"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select="t:backOffSet/t:reps"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
                <h3>Cardio</h3>
                <table class="roster">
                    <tr>
                        <th>Exercise</th>
                        <th>Photo</th>
                        <th>Period</th>
                        <th>Speed</th>
                        <th>Incline</th>
                    </tr>


                    <xsl:for-each select="t:training/t:cardio">
                        <tr>
                            <td>
                                <xsl:value-of select="t:name"/>
                            </td>
                            <td>
                                <xsl:apply-templates select="t:exercisePhoto" mode="cardioPhoto"/>
                            </td>
                            <td>
                                <xsl:value-of select="t:period"/> minutes </td>
                            <td>
                                <xsl:value-of select="t:speed"/> km/h </td>
                            <td>
                                <xsl:value-of select="t:incline"/> % </td>
                        </tr>
                    </xsl:for-each>

                </table>
                <h3>Summary</h3>

                <table class="roster">
                    <tr>
                        <th>Estimated Time</th>
                        <th>Number of exercises</th>
                        <th>Targeted Muscles</th>
                        <th>Photo</th>
                    </tr>

                    <xsl:for-each select="t:training/t:summary">
                        <tr>
                            <td>
                                <xsl:value-of select="t:estimatedTime"/> hours </td>
                            <td>
                                <xsl:value-of select="t:quantity"/>
                            </td>
                            <td>
                                <xsl:value-of select="t:primaryMuscle"/>
                            </td>
                            <td bgcolor="{$barva}">
                                <xsl:apply-templates select="t:musclesTargetedPhoto"
                                    mode="musclesTargetedPhoto"/>
                            </td>
                        </tr>

                    </xsl:for-each>
                </table>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="t:plan">
        <xsl:result-document href="{generate-id(t:name)}.html" format="html5">
            <html lang="en">
                <head>
                    <meta name="author" content="Kevin Nguyen"/>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                    <link rel="stylesheet" href="plan.css" type="text/css"/>
                    <title>
                        <xsl:value-of select="t:name"/>
                    </title>
                </head>
                <body>
                    <h1>
                        <a href="treninkovyPlan.html">Training Plan</a>
                    </h1>
                    <h2>
                        <xsl:value-of select="t:name"/>
                    </h2>
                    <table class="dates">
                        <tr>
                            <td>Start</td>
                            <td>
                                <xsl:apply-templates select="t:start" mode="date"/>
                            </td>
                        </tr>
                        <tr>
                            <td>End</td>
                            <td>
                                <xsl:apply-templates select="t:end" mode="date"/>
                            </td>
                        </tr>
                    </table>
                    <xsl:apply-templates select="t:day" mode="exercise_table"/>
                    <footer>&#xA9;2024 Kevin Nguyen</footer>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="t:plan/t:name">
        <h2 id="{generate-id()}">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

    <xsl:template match="t:start" mode="date">
        <xsl:value-of select="format-date(xs:date(.), '[D01].[M01].[Y]')"/>
    </xsl:template>

    <xsl:template match="t:end" mode="date">
        <xsl:value-of select="format-date(xs:date(.), '[D01].[M01].[Y]')"/>
    </xsl:template>












</xsl:stylesheet>
