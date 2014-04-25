
# Dette skal bli ei makefil for å lage smeeng.fst, 
# ei fst-fil som tar nob og gjev ei sme-omsetjing.

# Førebels er det berre eit shellscript.

echo ""
echo ""
echo "---------------------------------------------------"
echo "Shellscript to make a transducer of the dictionary."
echo ""
echo "It writes a lexc file to bin, containing the line	 "
echo "LEXICON Root										 "
echo "Thereafter, it picks lemma and first translation	 "
echo "of the dictionary, adds them to this lexc file,	 "
echo "and compiles a transducer bin/smeeng.fst		 "
echo ""
echo "Usage:"
echo "lookup bin/smeeng.fst"
echo "---------------------------------------------------"
echo ""
echo ""

echo "LEXICON Root" > bin/smeeng.lexc
cat src/*_smeeng.xml | \
grep '^ *<[lt][ >]'  | \
sed 's/^ *//g;'      | \
sed 's/<l /™/g;'     | \
tr '\n' '£'          | \
sed 's/£™/€/g;'      | \
tr '€' '\n'          | \
tr '<' '>'           | \
cut -d'>' -f2,6      | \
tr '>' ':'           | \
tr ' ' '_'           | \
sed 's/$/ # ;/g;'    >> bin/smeeng.lexc        

#xfst -e "read lexc < bin/smeeng.lexc"

printf "read lexc < bin/smeeng.lexc \n\
invert net \n\
save stack bin/smeeng.fst \n\
quit \n" > tmpfile
xfst -utf8 < tmpfile
rm -f tmpfile
