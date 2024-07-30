from fastapi import APIRouter, Request
from starlette.templating import Jinja2Templates

member_router = APIRouter()
templates = Jinja2Templates(directory='views/templates')

@member_router.get('/login')
async def login(req: Request):
    return templates.TemplateResponse('member/login.html', {'request': req})

@member_router.get('/join')
async def join(req: Request):
    return templates.TemplateResponse('member/join.html', {'request': req})

@member_router.get('/myinfo')
async def myinfo(req: Request):
    return templates.TemplateResponse('/member/myinfo.html', {'request': req})
