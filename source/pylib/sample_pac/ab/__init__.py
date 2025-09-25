'''
sample_pac/ab/__init__.py
ab 패키지를 import 할때 자동 실행되는 파일입니다.
from sample_pac.ab import *을 수행시  a모듈만 자동 import 되도록 하기 위해 
__all__를 세팅
'''
__all__=['a']
print("sample_pac.ab 패키지 로드")

