#!~/.rvm/bin/ruby
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
	
	def self.print_el_list(lista)
		count=0
		lista.each do |el|
			if el
				print "#{el}"
			else
				print "null"
			end
			if count<lista.length-1
				print ","
			end
			count+=1
		end
	end
	
	def print_element()
		puts "#{@name}: #{element_type} ("
		
		print "\tprev => ["
		TrackElement.print_el_list(prev_element_list)
		print "]"
		
		puts
		
		print "\tnext => ["
		TrackElement.print_el_list(next_element_list)
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
	routes.each do |route|
		if routes_indexes.include? routes.find_index(route)
			nodes=nodes.concat(route)
			train_stops.push route.last
		end
	end
	aborting_list=[]
	nodes.each do |node|
		aborting_list.push "False"
	end
	
	print "#{name}: Train (\n"
	print "\troutes => [";	TrackElement.print_el_list(routes_indexes);	print "]\n"
	print "\tnodes => [";	TrackElement.print_el_list(nodes);	print "]\n" #{nodes},\n"
	print "\taborting => [";	TrackElement.print_el_list(aborting_list);	print "]\n"#{aborting_list},\n"
	print "\tstops => [";	TrackElement.print_el_list(train_stops);	print "]\n"#{train_stops},\n"
	print "\tnode => #{starting_node}\n"
	print ");\n"

end


routes=[['GA1','N1','GA3'],
		['GA1','GA3'],
		['GA3','N1','GA1']]
elements=get_elements(routes)
init_track_elements(elements,routes)


elements.each do |trackEl|
	trackEl.print_element
end
puts ""
print_train_obj("meucci",routes,[0,2])
