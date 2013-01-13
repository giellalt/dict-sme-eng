
# Dette skal bli ei makefil for å lage smeeng.fst, 
# ei fst-fil som tar nob og gjev ei sme-omsetjing.

# Førebels er det berre eit shellscript.

# Kommando for å lage smeeng.fst
echo "LEXICON Root" > bin/smeeng.lexc
cat src/sme-eng-dump.xml | tr '\n' '™' | sed 's/<e>/£/g;'| tr '£' '\n'| sed 's/<re>[^>]*>//g;'|tr '<' '>'| cut -d">" -f5,15| tr ' ' '_'| tr '>' ':'| grep -v '__'|sed 's/;/%;/g;'|sed 's/$/ # ;/g' | grep '[a-zA-Z]'>> bin/smeeng.lexc
xfst -e "read lexc < bin/smeeng.lexc"

# deretter i xfst:
# invert
# save bin/smeeng.fst