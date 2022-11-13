#!/bin/bash

echo '' > books.html

echo '
<!DOCTYPE html>
<html lang="ru">

    <head>
        <meta charset="utf-8">

        <style>

            body 
            {

                font-family: Monofur NF, Roboto, Helvetica;

                text-align: left;
                text-indent: 50px; 

                padding-top: 5px;  
                padding-bottom: 5px;  
                padding-right: 5px;  
                padding-left: 30px;  

                margin-right: auto;
                margin-left: auto;
                padding: 10px;
                border: 3px solid #ffffff;
                width: 500px;
                box-sizing:border-box;


            }

        </style>
    </head>


    <body>
    ' >> books.html

#generate list of links for all founded html files in subfolders
find -mindepth 2 -maxdepth 2 -name "*.*html" | sort | sed -re 's|^\.\/||' | sed -re 's|(^.*$)|<a href="\1">\1</a>|'\
   | sed -re 's|/[^>]+</a>|</a>|' | sed -re 's|<a |<br><a |'  >> books.html


echo '

    </body>
</html>
' >> books.html
