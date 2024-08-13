from fastapi import APIRouter, Request
from starlette.templating import Jinja2Templates

practice_router = APIRouter()
templates = Jinja2Templates(directory='frontend/views/templates')

@practice_router.get('/css')
async def css(req: Request):
    return templates.TemplateResponse('practice/css.html', {'request': req})

@practice_router.get('/js')
async def js(req: Request):
    return templates.TemplateResponse('practice/js/js.html', {'request': req})

@practice_router.get('/js2')
async def js(req: Request):
    return templates.TemplateResponse('practice/js/js2.html', {'request': req})

@practice_router.get('/ajax')
async def ajax(req: Request):
    return templates.TemplateResponse('practice/js/ajax.html', {'request': req})



