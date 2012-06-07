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
	
	def print_el_list(lista)
		lista.each do |el|
			if el
				print "#{el.get_name}"
			else
				print "null"
			end
			if lista.find_index(el)<lista.length-1
				print ","
			end
		end
	end
	
	def print_element()
		p "#{@name}: #{element_type} ("
		
		print "\tprev => ["
		print_el_list(prev_element_list)
		print "]"
		
		puts
		
		print "\tnext => ["
		print_el_list(next_element_list)
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



routes=[['GA1','N1','GA3'],
		['GA1','GA3'],
		['GA3','N1','GA1']]
elements=get_elements(routes)


init_track_elements(elements,routes)

elements.each do |trackEl|
	trackEl.print_element
end
