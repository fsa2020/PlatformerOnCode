from pygments import highlight
from pygments.lexers import CppLexer
from pygments.lexers import LuaLexer
from pygments.lexers import PythonLexer
from pygments.formatters import HtmlFormatter
import html
import json
import pygments.lexers

def change_ESC(content):
    return html.unescape(content)

def parse_html(html):
    lines = html.split('\n')
    
    result = []
    for line in lines:
        blocks = line.split('<span')
        result.append([])
        for block in blocks:        
            if 'class=' in block:
                content = block.split('>')[1].split('<')[0]
                content = change_ESC(content)
                span_class = block.split('class="')[1].split('"')[0]
                result[-1].append((content, span_class))
    
    # print(result)
    # for l in result:
    #     if len(l)>0:
    #         print([b[1] for b in l])
    #     else:
    #         print("\n")
    return result
 
lvId = str(4)

cPath = "platformer_floor/codeFloor/floor"+lvId+".cpp"
jPath = "platformer_floor/codeFloor/floor"+lvId+".json"

with open(cPath, 'r') as file:
    code = file.read()

htmlCode = highlight(code, CppLexer(), HtmlFormatter())

result = parse_html(htmlCode)

tailEmptyNum = 0
for i in range(len(result)-1,-1,-1):
    if len(result[i]) == 0:
        tailEmptyNum += 1
    else:
        break
result = result[:-tailEmptyNum]

for r in result:
    print(r)

with open(jPath, 'w') as f:
    json.dump(result, f)
