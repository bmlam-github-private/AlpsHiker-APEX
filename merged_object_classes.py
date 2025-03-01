class MergedWay ():
	def __init__ ( self
		, id_str="", way_ids= [], node_ids= [], way_names= None, other_info = {}
		):
		self.id_str = id_str
		self.way_ids = way_ids
		self.node_ids = id_str
		self.way_names = way_names
		self.other_info = other_info

	def __repr__( self ):
		return "MergedWay did not implement its __repr__ yet"