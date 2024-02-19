extends Node

enum BlockType {EMPTY,KEY, NAME,  NUM, STR,COMMENT,OTHER,CP,CPF,NC,O,P,NF,LINE}

var SIMPIFY_TYPE = {
	'w':    BlockType.EMPTY,
	'k':    BlockType.KEY,
	'kt':   BlockType.KEY,
	'n':    BlockType.NAME,
	'nf':   BlockType.NF,
	'nb':   BlockType.KEY,
	'm':    BlockType.NUM,
	's':    BlockType.STR,
	'c':    BlockType.COMMENT,
	'cp':   BlockType.CP,
	'cpf':  BlockType.CPF,
	'nc':  	BlockType.NC,
	'o':	BlockType.O,
	'p':	BlockType.P,
	'mi':   BlockType.NUM,
	'mf':   BlockType.NUM,
	'c1':	BlockType.COMMENT,
	'line':	BlockType.LINE,
}

@export var TYPE_COLOR = {
	BlockType.EMPTY     : Color("#5f4d00"),
	BlockType.KEY       : Color("#569CD6"),
	BlockType.NAME      : Color("#9CDCFE"),
	BlockType.NUM       : Color("#B5CEA8"),
	BlockType.STR       : Color("#CE9178"),
	BlockType.COMMENT   : Color("#6A9955"),
	BlockType.OTHER     : Color("#5b3f49"),
	BlockType.CP     	: Color("#C586C0"),
	BlockType.CPF     	: Color("#CE9178"),
	BlockType.NC     	: Color("#4EC9B0"),
	BlockType.O     	: Color("#CCCCCC"),
	BlockType.P     	: Color("#569CD6"),
	BlockType.NF     	: Color("#DCDCAA"),
	BlockType.LINE		: Color("#DCDCAA"),
}

