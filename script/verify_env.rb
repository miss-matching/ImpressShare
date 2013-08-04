command = './script/markdown2impress/bin/markdown2impress.pl' 
target = './script/markdown2impress/README.md'
dest_dir = './script/markdown2impress'

result_for_markdown2impress = system( "#{command} #{target} --outputdir=#{dest_dir}" )
p 'you are ready to go widh markdown2impress!' if result_for_markdown2impress
