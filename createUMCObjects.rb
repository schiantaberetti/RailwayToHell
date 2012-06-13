#!~/.rvm/bin/ruby
class Array
	def to_s
		string=""
		count=0
		self.each do |el|
			if el
				string.concat el.to_s
			else
				string.concat "null"
			end
			if count<self.length-1
				string.concat ","
			end
			count+=1
		end
		string
	end
end

class TrackElement

	attr_accessor :element_type
	attr_accessor :prev_element_list
	attr_accessor :next_element_list
	attr_accessor :name
	
	def initialize(n,t="")
		@name=n
		@type=t
		@prev_element_list=[]
		@next_element_list=[]
	end

	def get_name()
		@name
	end
	
	def set_prev_el(route_pos,trEl)
		@prev_element_list[route_pos]=trEl
	end
	
	def set_next_el(route_pos,trEl)
		@next_element_list[route_pos]=trEl
	end
	
	def get_prev_el(route_pos)
		@prev_element_list[route_pos]
	end
	
	def get_next_el(route_pos)
		@prev_element_list[route_pos]
	end
	
	def to_s()
		@name
	end
	

	
	def print_element()
		puts "#{@name}: #{element_type} ("
		
		print "\tprev => ["
		print prev_element_list
		print "],"
		
		puts
		
		print "\tnext => ["
		print next_element_list
		print "]"
		
		puts ");"
		
	end
end

def init_track_elements(elements,routes)
	route_pos=0
	routes.each do |route|
		elements.each do |trackEl|
			if route.include? trackEl.get_name
				el_index=route.find_index(trackEl.get_name)
				#puts "#{trackEl.get_name} ha index #{el_index}"
				if(el_index>0)
					trackEl.set_prev_el(route_pos,TrackElement.new(route[el_index-1]))
				else
					trackEl.set_prev_el(route_pos,nil)
				end
				if(el_index<route.length-1)
					trackEl.set_next_el(route_pos,TrackElement.new(route[el_index+1]))
				else
					trackEl.set_next_el(route_pos,nil)
				end
			else
				trackEl.set_next_el(route_pos,nil)
				trackEl.set_prev_el(route_pos,nil)
			end
		end
		route_pos+=1
	end
end

def get_elements(routes)
	elements_name=[]
	elements=[]
	routes.each do |route|
		elements_name=elements_name.concat(route)
	end
	elements_name = elements_name.uniq
	#print elements_name
	
	elements_name.each do |el_name|
		elements.push(TrackElement.new(el_name))
	end
	elements


end

def print_train_obj(name,routes,routes_indexes)
	starting_node=routes[routes_indexes[0]][0]
	nodes=[]
	train_stops=[]
	tmp_route=[]
	routes_indexes.each do |route_index|
		route=routes[route_index]
		if nodes.last==route.first
			tmp_route=route[1..route.length-1]
		else
			tmp_route=route
		end
		nodes=nodes.concat(tmp_route)
		train_stops.push tmp_route.last
	end
	


	aborting_list=[]
	nodes.each do |node|
		aborting_list.push "False"
	end
	
	print "#{name}: Train (\n"
	print "\troutes => [ #{routes_indexes }],\n"
	print "\tnodes => [ #{nodes}],\n"
	print "\taborting => [#{aborting_list}],\n"
	print "\tstops => [#{train_stops}],\n"
	print "\tnode => #{starting_node}\n"
	print ");\n"

end

=begin
routes=[['GA1','N1','GA3'],
		['GA1','GA3'],
		['GA3','N1','GA1']]
=end
filename=""
if ARGV.length>0
	filename=ARGV[0]
end
if filename==""
	print "[Error] Route File Required.\n"
	exit 1
end

routes=[]
open(filename).each do |line|
	route=line.split(' ')
	routes.push route
end

elements=get_elements(routes)
init_track_elements(elements,routes)


elements.each do |trackEl|
	trackEl.print_element
end
puts ""
print_train_obj("locomotive",routes,[14])
