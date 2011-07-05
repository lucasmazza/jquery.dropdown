watch( 'src/.*\.styl' )  {|match| `stylus #{match[0]} -c -o lib/` }
watch( 'src/.*\.coffee' )  {|match| `coffee -o lib/ -c #{match[0]}` }