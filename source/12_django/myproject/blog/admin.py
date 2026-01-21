from django.contrib import admin
from .models import Post
admin.site.register(Post) # admin 페이지에 Post 테이블 엑세스 가능