# show-data.rb
#
# show_data -- show the results of any data a pretty way
#
# Alan K. Stebbens, aks@stebbens.org, Jan 2008
#
# 2008/10/14 aks: 
#  Added support for OpenStruct objects
#  Fixed symbol key representation

require 'ostruct'

def format_data(data, indent=0)
  s = ''
  klass = data.class
  if (klass == Array) 
    s += format_array( data, indent )
  elsif klass == Hash
    s += format_hash( data.keys, data.values, indent )
  elsif %w( Time Date DateTime ).include?(klass.to_s)
    s += data.to_s                      # use default formatting
  elsif klass == OpenStruct
    s += (prefix = "#<OpenStruct")
    hash = data.marshal_dump
    s += format_hash( hash.keys, hash.values, indent + prefix.length, ' ', '>' )
  elsif data.inspect =~ /^(\#<struct \w+)/	# structure?
    s += $1 + ' '
    s += format_hash(data.members, data.values, indent + $1.length + 1, ' ', '>' )
  elsif data.respond_to?(:attributes)
    attrs = data.attributes
    if (text = data.inspect) =~ /^(\#<[^:>]+: )/
      s += (prefix = $1)
    else
      s += (prefix = text.split(' ').first)
    end
    s += format_hash(attrs.keys, attrs.values, indent + prefix.length, ' ', '>')
  elsif data.respond_to?(:instance_variables) and (vars = data.instance_variables.sort).size > 0
    s += (prefix = data.inspect.split(' ').first) + ' '
    s += format_hash(vars, vars.map{|v| data.instance_eval(v.to_s)}, indent + prefix.length + 1, ' ', '>')
  else
    s += data.inspect
  end
  s += "\n" if indent == 0
  s
end

def format_array( data, indent, open_char = '[', close_char = ']' )
  indexlen = data.size.to_s.length
  s = "["
  indexfmt = "[%0#{indexlen}d]: "
  nextindent = indent + indexlen + 5
  indentstr = ' ' * nextindent
  data.each_index do |x|
    s += sprintf(indexfmt, x)
    s += format_data(data[x], nextindent)
    s += sprintf(",\n" + ' '*indent + ' ') unless x == data.length - 1
  end
  s += "\n" + ' ' * indent + ']'
end

# format a hash
#    args: keys, values, indent, open char, close char, right-align
# returns: formatted string
#
# if the hash looks like this: { 'key1' => 'value1', 'key2' => 'value2', 'key3' => 'value3' }
# then display it like this:
#
#  {      'key1' => 'value1',
#    'aLongkey2' => 'value2',
#         'key3' => 'value3'
#   }
#
# the formatter tries to align the '=>' and everything around it, unless the
# FALSE object is passed as the "right_align" value.
#
# Recursively format nested object values.  The '{' and '} are defaults.
#

def format_hash( hash_keys, hash_values, indent, open_char = '{', close_char = '}', right_align = nil)
  s = open_char + ' '
  maxkeylen = 0
  if right_align or right_align.nil?		# align maybe?
    #complex = 0
    hash_keys.each_index do |x| 
      k, v = hash_keys[x], hash_values[x]
      kl = k.class == Symbol ? 1 + k.to_s.length : 2 + k.length
      maxkeylen = kl if maxkeylen < kl 
      #complex += v.size if v.class == Hash || v.class == Array || v.class == OpenStruct
    end
    # if the data complexity is < 60%, and the maxkeylen is defined, then allow right-align
    #maxkeylen = 0 if hash_keys.size > 0 && (complex.to_f / hash_keys.size.to_f) < 0.6
  end
  keyfmt = maxkeylen > 0 ?  "%#{maxkeylen}s => " : "%s => "
  indentstr = ' ' * indent + '  '
  count = 0
  hash_keys.each_index do |x|
    key, val = hash_keys[x], hash_values[x]
    if key.class == Symbol			# Symbols have different representation
      formatted_key = sprintf(keyfmt, ':' + key.to_s)	# :somesymbol
    else
      formatted_key = sprintf(keyfmt, "'" + key + "'")	# 'somekey'
    end
    s += formatted_key
    vs = format_data(val, indent + formatted_key.size + 2)
    s += vs
    count += 1
    s += ",\n" + indentstr unless count >= hash_keys.size
  end
  s += "\n" + ' ' * indent + close_char
end

def show_data(data, indent=0)
  puts format_data(data, indent)
end

# end of show-data.rb
# vim: sw=2 ai
