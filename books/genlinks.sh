#!/bin/bash

echo '' > index.html

echo '
<!DOCTYPE html>
<html lang="ru">

    <head>
        <meta charset="utf-8">

        <style>

            body 
            {

                font-family: Comfortaa, Monofur NF, Roboto, Helvetica;

                text-align: left;
                <!-- text-indent: 100px; --> 

                padding-top: 5px;  
                padding-bottom: 5px;  
                padding-right: 5px;  
                padding-left: 30px;  

                margin-right: auto;
                margin-left: auto;
                padding: 10px;
                border: 3px solid #ffffff;
                width: 70%;
                box-sizing:border-box;


            }

            /* Tooltip container */
            .tooltip {
                position: relative;
                display: inline-block;
                <!-- border-bottom: 1px dotted black; -->
            }

            /* Tooltip text */
            .tooltip .tooltiptext {
                visibility: hidden;

                <!-- width: 120px; -->
                width: 100%;

                background-color: #555;
                color: #fff;
                text-align: center;
                border-radius: 6px;
                padding: 5px 0;

                /* Position tooltip text*/
                position: absolute;
                z-index: 1;
                bottom: 125%;
                left: 50%;
                <!-- margin-left: -60px; -->

                /*Fading tooltip text*/
                opacity: 0;
                transition: opacity 0.3s linear 1s;
            }

            /* Tooltip arrow */
            .tooltip .tooltiptext::after {
                content: "";
                position: absolute;
                top: 100%;
                left: 50%;
                margin-left: -5px;
                border-width: 5px;
                border-style: solid;
                border-color: #555 transparent transparent transparent;
            }

            /* Show the tooltip text when you mouse over the tooltip container */
            .tooltip:hover .tooltiptext {
                visibility: visible;
                opacity: 1;
            }


        </style>
    </head>


    <body>
    ' >> index.html

#generate list of links for all founded html files in subfolders
# find -mindepth 2 -name "*.*html" | sort | sed -re 's|^\.\/||' | sed -re 's|(^.*$)|<a href="\1">\1</a>|'\
#    | sed -re 's|/[^>]+</a>|</a>|' | sed -re 's|<a |<br><a |'  >> index.html

# find -mindepth 2 -name "*.*html" | sort\
#    | sed -re 's|^\.\/||'\
#    | sed -re 's|(^.*$)|<a href="\1">\1</a>|'\
#    | sed -re 's|/[^>/]+</a>|</a>|'\
#    | sed -re 's|>[^<>]+/|>|'\
#    | sed -re 's|<a |<br><a |'  >> index.html

# FIND=/tmp/genlinks_find.txt
# find -mindepth 2 -name "*.*html" | sort > "$FIND"

find -mindepth 2 -name "*.*htm*" | sort\
   | sed -re 's|^\.\/||'\
   | sed -re 's|(^.*$)|<a class="tooltip" href="\1">\1<span class="tooltiptext">\1</span></a>|'\
   | sed -re 's|/[^>/]+<span|<span|'\
   | sed -re 's|>[^<>]+/|>|'\
   | sed -re 's|<a |<br><a |'\
   >> index.html



echo '

    </body>
</html>
' >> index.html

