command = 'script/markdown2impress/bin/markdown2impress.pl' 
target = 'script/markdown2impress/README.md'

result_for_markdown2impress = system( "#{command} #{target}" )
p 'you are redy to go widh markdown2impress!' if result_for_markdown2impress
