<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="iso-8859-1" indent="yes" />

    <xsl:template match="/films">
        <html>
            <head>
                <title> Cinématographie </title>
                <link rel="stylesheet" type="text/css" href="film.css" />

                <script src="https://code.jquery.com/jquery-2.2.4.min.js"> </script>
                <script src="scroll.js"> </script>
                <link rel="stylesheet" type="text/css" href="scroll.css" />
            </head>
            <body>
                <div id="main">
                    <section>
                        <h1>cinématographie</h1>

                        <h2>Table des matières des films</h2>

                        <ul>
                            <xsl:apply-templates select="film" mode="tdm">
                                <xsl:sort select="@anneeSortie" order="descending"
                                    data-type="number" />
                                <xsl:sort select="exploitation/nbrEntrees" order="descending"
                                    data-type="number" />
                            </xsl:apply-templates>
                        </ul>
                    </section>

                    <section>
                        <h2>Table des matières des acteurs</h2>
                        <ul>
                            <xsl:apply-templates select="acteurDescription">
                                <xsl:sort select="id" order="ascending" data-type="number" />
                            </xsl:apply-templates>
                        </ul>
                    </section>


                    <xsl:apply-templates select="film" mode="complet">
                        <xsl:sort select="@anneeSortie" order="descending" data-type="number" />
                        <xsl:sort select="exploitation/nbrEntrees" order="descending"
                            data-type="number" />
                    </xsl:apply-templates>

                </div>
                <script>
                    $("#main").onepage_scroll({
                    sectionContainer: "section",
                    easing: "ease",
                    animationTime: 1000,
                    pagination: true,
                    updateURL: false,
                    beforeMove: function(index) {},
                    afterMove: function(index) {},
                    loop: false,
                    keyboard: true,
                    responsiveFallback: false
                    });

                </script>
            </body>
        </html>
    </xsl:template>


    <xsl:template match="film" mode="complet">
        <section>
            <xsl:if test="@anneeSortie='2023'">
                <h3 class="nouvSortie"> Nouveauté !!!! </h3>
            </xsl:if>

            <a>
                <xsl:attribute name="data-index"><xsl:value-of select="position()+2" /></xsl:attribute>
                <img src="{image/@ref}" alt="image du film" />
            </a>

            <h2>

                <!--<xsl:attribute
                name="name"><xsl:value-of select="titre" /></xsl:attribute>-->
                <xsl:value-of select="titre" />


            </h2>
            <b>Genres : <xsl:for-each
                    select="genres/genre">
                    <xsl:value-of select="text()" />, </xsl:for-each>
            </b>
            <br />
            <br />
            <i>film <xsl:value-of
                    select="nationalite" /> de <xsl:value-of select="duree" />mn sorti en <xsl:value-of
                    select="@anneeSortie" /></i>
            <p>*réalisé par <xsl:value-of
                    select="realisateur/@prenom" /> <xsl:value-of select="realisateur/@nom" />*</p>
            <p>Liste
                des acteurs : </p>
            <ul>
                <xsl:for-each select="acteurs/acteur">
                    <li>
                        <xsl:value-of select="text()" />
                    </li>
                </xsl:for-each>
            </ul>

            <p>
                <xsl:apply-templates select="scenario" />
            </p>
        </section>
    </xsl:template>


    <xsl:template match="film" mode="tdm">
        <li>

            <!--<xsl:attribute
            name="href">#<xsl:value-of select="titre" /></xsl:attribute>-->
                <a href="javascript:void(0);" onclick="$.fn.moveTo({position()+2})">
                <xsl:value-of select="titre" />
            </a> ( <xsl:value-of
                select="count(acteurs/acteur)" /> acteurs) <i> [<xsl:for-each
                    select="scenario/keyword"><xsl:value-of select="text()" /> / </xsl:for-each>] </i>
        </li>
    </xsl:template>

    <xsl:template match="acteurDescription">

        <xsl:variable name="idActeur">
            <xsl:value-of select="@id" />
        </xsl:variable>

    <li>
            <xsl:value-of select="prenom" />_<xsl:value-of select="nom" /> né(e) le <xsl:value-of
                select="dateNaissance" /> //// ( a joué(e) dans <xsl:value-of
                select="count(//film[acteurs/acteur[@ref=$idActeur]])" /> film(s) ) //// <xsl:for-each
                select="//film[acteurs/acteur[@ref = $idActeur]]">
                <xsl:text> film n°</xsl:text> 
       <!-- <a>
                    <xsl:attribute name="href">#<xsl:value-of select="titre" /></xsl:attribute>
                    <xsl:value-of select="position()" />
                </a>-->
                <a href="javascript:void(0);" onclick="$.fn.moveTo({position()+2})">
                    <xsl:value-of select="position()" />
                </a>
            </xsl:for-each>
        </li>

    </xsl:template>


    <xsl:template match="scenario">
        <div class="histoireType">
            <xsl:apply-templates />
        </div>
    </xsl:template>

    <xsl:template match="ev">
        <i>
            <xsl:apply-templates />
        </i>
    </xsl:template>

    <xsl:template match="personnage">
        <b>
            <xsl:apply-templates />
        </b>
    </xsl:template>


</xsl:stylesheet>