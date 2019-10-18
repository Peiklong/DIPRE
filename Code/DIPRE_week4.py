import re
import pymysql
from operator import itemgetter
from itertools import groupby
CONST_M = 20 # 定义常量m，在记录事件时使用

db = pymysql.connect("localhost","root","","DIPRE" ) # 连接数据库
cursor = db.cursor()
cursor.close()

def GetData(): # 获取数据库中的数据，以列表—字典的形式返回
    cursor = db.cursor()
    sql = "select * from webpage"
    data = []
    try:
        cursor.execute(sql)
        results = cursor.fetchall()
        for row in results:
            each = {}
            each['id'] = row[0]
            each['url'] = row[1]
            each['text'] = row[2].replace('\n',' ')
            data.append(each)
    except:
        db.rollback()
    cursor.close()
    return data
data = GetData()
data

seeds = [] # 手动形成种子，后续改为从数据库中获取种子
book1 = {'author':'Charles Dickens','title':'Great Expectations'}
book2 = {'author':'Nicholas Sparks','title':'The Last Song'}
book3 = {'author':'Michaels, Kasey','title':'The Sheikh\'s Secret Son (The Fortunes of Texas)'}
book4 = {'author':'Clare, Cassandra','title':'City of Heavenly Fire (The Mortal Instruments)'}
seeds.append(book1)
seeds.append(book2)
seeds.append(book3)
seeds.append(book4)
seeds

def SearchSeedInLine(author,title,url,line): # 在一行中搜索一个种子的元组对（先假设只有一行）
    occurrence = {}
    if author in line and title in line: # 作者和标题都在该行则记录事件,需要先判定是作者在前还是标题在前
        posA = line.index(author)
        posT = line.index(title)
        if(posA<posT): # 如果作者在前则为1，否则为0
            order = 1
            if posA-CONST_M>=0:
                prefix = line[posA-CONST_M:posA] # 记录author前m个字符作为前缀
            else:
                prefix = line[:posA] # 如果前m个字符超出下界则m记为0
            middle = line[posA+len(author):posT]
            suffix = line[posT+len(title):posT+len(title)+CONST_M] # 记录title后m个字符作为后缀，后界不用if，因为默认超出len按len计算
        else:
            order = 0
            if posT-CONST_M>=0:
                prefix = line[posT-CONST_M:posT]
            else:
                prefix = line[:posT]
            middle = line[posT+len(title):posA]
            suffix = line[posA+len(author):posA+len(author)+CONST_M]
        occurrence['author'] = author # 记录事件并返回
        occurrence['title'] = title
        occurrence['order'] = order
        occurrence['url'] = url
        occurrence['prefix'] = prefix
        occurrence['middle'] = middle
        occurrence['suffix'] = suffix
        return occurrence
    return None
occurrence = SearchSeedInLine(seeds[0]['author'],seeds[0]['title'],data[0]['url'],data[0]['text'])
occurrence # 在第一个数据中搜索到的第一个种子

def SearchSeeds(): # 在所有数据中搜索所有种子
    ouccurrences = [] # 事件列表
    for seed in seeds:
        for page in data:
            occurrence = SearchSeedInLine(seed['author'],seed['title'],page['url'],page['text'])
            if occurrence is not None:
                ouccurrences.append(occurrence)
    return ouccurrences
occurrences = SearchSeeds()
occurrences # 在所有数据中搜索到的所有种子结果

def GroupByUrl(lists): # 从已经通过order和middle分组的数据组中再通过网址进行分组
    patterns = []
    for each in lists:
        each['url'] = each['url'].split('/')[0] # 切割分组后每组数据的url，取主网址
    for url,items in groupby(lists,key = itemgetter('url')): # 再通过url主网址进行分组
        lists = list(items)
        if len(lists) > 1:
            pattern = GetPrefixAndSuffix(lists)
            if pattern is not None:
                patterns.append(pattern) # 这里获取到的是一个模式集合，因此在列表中追加即可
    return patterns

def GetPrefixAndSuffix(lists): # 经过order、middle和url的分组后，剩下的不再分组，形成一个模式
    prefix = lists[0]['prefix'] # 匹配每组数据中公共的前缀，不保证不为空
    suffix = lists[0]['suffix']
    for each in lists:  # 这里的操作是默认前缀为第一个数据，然后与后面的数据进行匹配，在第一个数据的基础上做缩减操作
        i = len(prefix)-1
        j = len(each['prefix'])-1
        while i>=0 and j>=0 and each['prefix'][j] == prefix[i]:
            i = i-1
            j = j-1
        prefix = prefix[i+1:]
        
        m = 0
        n = 0
        while m<len(suffix) and n<len(each['suffix']) and each['suffix'][n] == suffix[m]:
            m = m+1
            n = n+1
        suffix = suffix[:m]
    pattern = {}
    pattern['prefix'] = prefix.strip()
    pattern['suffix'] = suffix.strip()
    pattern['order'] = lists[0]['order']
    pattern['middle'] = lists[0]['middle'].strip()
    pattern['url'] = lists[0]['url']
    if len(pattern['prefix']) and len(pattern['suffix']) and len(pattern['url']):
        return pattern
    return None

def GroupByOrderAndMiddle(): # 通过order和middle进行分组，并对每组数据形成模式
    patterns = []
    occurrences.sort(key = itemgetter('order')) # 按照对order字段进行排序
    for middle,items in groupby(occurrences,key = itemgetter('middle')): # groupby（）函数在每次迭代的时候，会返回一个分组后的分组值和一个迭代器对象，迭代器对象包含对应分组值的所有对象。
        lists  = list(items) # 迭代器只能迭代一次，所以转化为列表进行操作
        if len(lists) > 1: # 每类分组中需要至少两组数据才能形成模式
            eachpatterns = GroupByUrl(lists) # 这里eachpatterns的结构为[{'a':'a','b':'b'},{'a':'c','b':'d'}]，因此需要用+做合并列表操作
            patterns = patterns + eachpatterns
    return patterns
patterns = GroupByOrderAndMiddle()
patterns

def FindBooksByPattern(MyPattern): # 通过一个模式在数据中查找书籍元组
    for item in data:
#         print(item)
        if MyPattern['url'] in item['url']:
            NewPattern = re.compile(MyPattern['prefix']+'(.*?)'+MyPattern['middle']+'(.*?)'+MyPattern['suffix'],re.I)
            m = NewPattern.finditer(item['text'])
            if m is not None:
                for item in m:
                    print(item.groups())
FindBooksByPattern(patterns[0])





