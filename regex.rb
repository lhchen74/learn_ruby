# create methods
# 1. /ruby/
# 2. %r{ruby}
# 3. Regexp.new

# =~
# If the String matches the expression, the operator returns the offset, and if it doesn't, it returns nil.

# basics
text = 'ruby'
p text =~ /ruby/
p text =~ /^ruby/
p text =~ /ruby$/
p text =~ /^ruby$/
p text =~ /^$/  # match empty string


# metacharacters
p text =~ /r.*y/
p text =~ /r.?y/
p text =~ /r.*?y/
p text =~ /r\w*y/
p text =~ /\W+/


# options 
p text =~ /Ruby/i
p text =~ /r.*y/im  # If set m option, . can match \n


# parenthesis, bracket and braces
p text =~ /r[abc]y/
p text =~ /r(.*)y/
p text =~ /r{2}/

text = 'abcd aabc asaaaabd'
p text.scan(/a*b/)  # ["ab", "aab", "aaaab"]
p text.match(/(a*b)/)[0]

text = 'hello there'
p text[/[aeiou](.)\1/]  # ell
p text[/[aeiou](.)(.)/] # ell

text = '(200)959-5592'
p text.split(/[\(\)-]/).reject{|e| e.empty?}
p text.gsub!(/[\(\)-]/, '@')


# Homework
# We want to get both {{mustache_template}}, and a normal substitution {like_this}, but not a {{{crazy_one}}}
text = "We want to get both {{mustache_template}}, and a normal substitution {like_this}, but not a {{{crazy_one}}}"
p text.scan(/\{{1,2}([^{}]+)\}{1,2}[^}]/)  # [["mustache_template"], ["like_this"]]
