#!/bin/sh

echo "Hello world"
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")


#rename file from [xxxx]yyyyy to yyyyy
remprefix()
{
  echo 'remprefix started'
  
  FLIST=/tmp/remprefix.list
  if [[ -e $FLIST ]] ; then
    rm -fv $FLIST
  fi
  
  LOGNAME=/tmp/remprefix.log
  if [[ -e $LOGNAME ]] ; then
    rm -fv $LOGNAME
  fi
   

  #rename file from [xxxx]yyyyy to yyyyy
  #find | egrep  "^\[.+\].+\..+" > "$FLIST"

  #rename file from 93 XXXXX to XXXXX
  #find | egrep  "^[0-9]+ .+\..+" > "$FLIST"

  #remove leading dot
  

  #rm leading dot
  #find -name '\.*' -type f -maxdepth 1 -exec sh -c '#set -x;

  #rm leading <5.  > 
  find -regex '\./[0-9]\+\.[ \t]\+.*' -type f -maxdepth 1 -exec sh -c '#set -x;
			    IFS=$(echo -en "\n\b");
			    file="$0";
			    #rm leading dot
			    #dest=$(echo $file | sed -r "s:^\.\/\.(.*)$:\1:")
			    #rm leading <5.  > 
			    dest=$(echo $file | sed -r "s:^\.\/[0-9]+\.[ \t]+(.*)$:\1:")
			    echo "$file->$dest";
			    mv "$file" "$dest" ;' {} \; 


  #while read p; do
  #  OLDNAME=$p
  #  #NEWNAME=$(echo "$p" | sed -r 's:^\[.+\](.+\..+):\1:')
  #  NEWNAME=$(echo "$p" | sed -r 's:^[0-9]+ (.+\..+):\1:')
  #  echo "$OLDNAME -> $NEWNAME" >> $LOGNAME
  #  mv $OLDNAME $NEWNAME >> $LOGNAME
  #done < $FLIST
}

flatDir()
{
  echo "flatDir started"
  CURRENTDIR="$PWD"
  
  TDIR="$1"
  if [[ ! -e $TDIR || ! -d $TDIR ]] ; then
      echo "path $TDIR does not exsist or is not a directory"
      exit 1
    else
      echo "Path $TDIR checked successfully"
  fi
  
  cd "$TDIR"
  export FTDIR="$PWD"
 
  find -type f -exec sh -c '#set -x;
			    IFS=$(echo -en "\n\b");
			    file="$0";
			    echo "$file";
			    mv "$file" "$FTDIR"' {} \; 
			    
  cd "$CURRENTDIR"
}


rmEmptyDirs()
{
  #set -x
  echo 'rmEmptyDirs started'
  
  
  TDIR="$1"
  if [[ ! -e $TDIR || ! -d $TDIR ]] ; then
      echo "path $TDIR does not exsist or is not a directory"
      exit 1
    else
      echo "Path $TDIR checked successfully"
  fi
  
  ##find $1 -depth -type d -exec sh -c '[ "$(ls -A {})" ] && echo "Not Empty" || {  echo "Empty -removing"; rmdir {}; }  ' \; -print  
  find $1 -depth -type d -exec sh -c '#set -x;
				      IFS=$(echo -en "\n\b");
  				      file="$0"; 
  				      echo "$file" ;
  				      [ "$(ls -A $file)" ] && { echo "Not Empty"; echo "     "; } || {  echo "Empty -removing"; rmdir "$file"; echo "     ";  } ' {} \;   
}


findall()
{
  echo 'findall stated'

  find /volume1/video -type f > /tmp/allfiles
  find /volume2/video1 -type f >> /tmp/allfiles
}

rmDup()
{
  echo 'rmdup started'

  egrep -v '(Thumbs.db|@eaDir)' < /tmp/allfiles > /tmp/nicefiles
  sed -r 's:/VIDEO_TS.*::' < /tmp/nicefiles > /tmp/nodvdfiles
  sort -u < /tmp/nodvdfiles > /tmp/unipaths
  sed -r 's:^.*/::' < /tmp/unipaths > /tmp/onlynames
  sort < /tmp/onlynames  | uniq -cd > /tmp/matches
  sort -u < /tmp/onlynames > /tmp/uninames
  grep -v jpg /tmp/matches | awk '{$1="";print $0;}' | sed -r s':^ ::' > /tmp/justnames
}

rmjpg()
{
  echo 'rmjpg started'

  find /volume1/video \( -name '*.vtx' -o -name '*.png' -o -name '*.jpeg' -o -name '*.jpg' -o -name '*.JPG' \) -exec rm {} \; -print > /tmp/rmjpglog
  find /volume2/video1 \( -name '*.vtx' -o -name '*.png' -o -name '*.jpeg' -o -name '*.jpg' -o -name '*.JPG' \) -exec rm {} \; -print >> /tmp/rmjpglog
}

findmatches()
{

  echo 'findmatches started'

  while read p; do
    echo '==========================' >> /tmp/findmat
    grep $p /tmp/unipaths >> /tmp/findmat
    echo '                          ' >> /tmp/findmat
  done < /tmp/justnames
}

justlist()
{
  echo 'justlist started'
  cat /tmp/findmat | grep -v '==============' | egrep -v '^ +$' |  sort > /tmp/justlist
  sed -r 's:/[^/]*$::' < /tmp/justlist | sort -u > justdirs
}

cleanold()
{
  echo 'cleanold started'
rm /tmp/justdirs
rm /tmp/justlist
rm /tmp/findmat
rm /tmp/justnames
rm /tmp/uninames
rm /tmp/matches
rm /tmp/onlynames
rm /tmp/unipaths
rm /tmp/nodvdfiles
rm /tmp/nicefiles
rm /tmp/allfiles
}

checkdup()
{
  echo 'checkdup started'
  cleanold
  findall
  rmDup
  findmatches
  justlist
}

flat()
{
  echo 'flat started'
  flatDir "$@"
  rmEmptyDirs "$@"
}


stub1()
{
  echo "stub1 started $1"
}

flatSubs()
{
  echo 'flatSubs started'
  
  CURRENTDIR="$PWD"
  
  TDIR="$1"
  if [[ ! -e $TDIR || ! -d $TDIR ]] ; then
      echo "path $TDIR does not exsist or is not a directory"
      exit 1
    else
      echo "Path $TDIR checked successfully"
  fi
  
  
  cd "$TDIR"
  rm -fv /tmp/forflats
  find $PWD -maxdepth 1 -type d ! -path $PWD > /tmp/forflats
  
  while read p; do
    flat "$p"
  done < /tmp/forflats 
			    
  cd "$CURRENTDIR"
}


justrme()
{
  echo 'justrme started'

  rmEmptyDirs /volume1/video
  rmEmptyDirs /volume2/video1
}

#Move to dir files in accordance with regexp
#input <dir> <regex>
mv2dir()
{
  echo 'mv2dir started'
  export TDIR="$1"
  if [[ ! -e $TDIR || ! -d $TDIR ]] ; then
      echo "path $TDIR does not exsist or is not a directory"
      exit 1
    else
      echo "Path $TDIR checked successfully"
  fi
  
  FLIST=/tmp/formv2dir
  rm -fv $FLIST
 
  ##find $PWD -maxdepth 1 -type f -regex "$2" 
  find $PWD -maxdepth 1 -type f -regex "$2" -exec sh -c '#set -x;
			    IFS=$(echo -en "\n\b");
			    file="$0";
			    echo "$file";
			    mv "$file" "$TDIR"' {} \; 

  
}

wordList()
{
  awk  '{for (i=1;i<=NF;i++) print $i}' | awk -F','  '{for (i=1;i<=NF;i++) print $i}' | awk -F'.'  '{for (i=1;i<=NF;i++) print $i}' |  awk -F'-'  '{for (i=1;i<=NF;i++) print $i}' | awk -F'_'  '{for (i=1;i<=NF;i++) print $i}' | sort -f | uniq -c | sort -fr

}

bydate()
{
  ls -lte | grep -v '^d' |  awk '{print $7,$8,$10}' | sort | uniq -c | sort -rf
}

#input <dir> <date>
#input date <Feb 21 2015>
mv2dirByDate()
{
  echo 'mv2dirByDate started'
  TDIR="$1"
  if [[ ! -e $TDIR || ! -d $TDIR ]] ; then
      echo "path $TDIR does not exsist or is not a directory"
      exit 1
    else
      echo "Path $TDIR checked successfully"
  fi

  PATTERN=$(echo "$2" | awk '{print $1,"?",$2,"(([0-9]{2}:){2}[0-9]{2})",$3}' ) 
  echo "PATTERN <$PATTERN>"

  FLIST=/tmp/mvByDate.list
  rm -fv $FLIST
  
  ls -lteh | grep -v '^d' |  egrep "$PATTERN" | awk '{ for(i=11;i<=NF;++i){printf " %s", $i} printf "\n"}' \
	| sed -r 's:^ ::' > $FLIST

  while read p; do
    echo "$p"
    mv "$p" "$TDIR"
  done < "$FLIST"

}

#sort files by date , calculate number of files for any date
# date:number_of_files
#if number_of_files more than 9 create directory with name as date e.g. 2015_Nov_11
#and move all files with such date creation to this folder
automvByDate()
{
  echo 'automvByDate started'
  TABLE=/tmp/table
  rm -fv $TABLE
  ls -lte | grep -v '^d' | awk '{print $7,$8,$10}' | sort | uniq -c | sort -r | awk '$1>9{print $0}' > $TABLE

  while read p; do
    echo "$p"
    TDIR=$(echo "$p" | awk '{OFS="_"; print $4,$2,$3}')
    if [[ -e "$TDIR" ]] ; then
	if [[ -d "$TDIR" ]] ; then
	    echo "Ok. $TDIR already exists. Moving files to it."
	else
	    echo "Ok. $TDIR already exists but not a folder. Skip. "
	    continue
	fi 
    else
	echo "$TDIR dosn't exists. Creating one."
	mkdir "$TDIR"
    fi 
    
    TDATE=$(echo "$p" | awk '{ print $2,$3,$4}')
    mv2dirByDate "$TDIR" "$TDATE"
  done < "$TABLE"

}


rmjpg
justrme
checkdup

#justrme

#remprefix

#flat "$@"

#flatSubs "$@"
#mv2dir "$@"
#mv2dirByDate "$@"
#automvByDate

IFS=$SAVEIFS

