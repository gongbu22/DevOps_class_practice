from fastapi import APIRouter, Request
from starlette.templating import Jinja2Templates

practice_router = APIRouter()
templates = Jinja2Templates(directory='frontend/views/templates')

@practice_router.get('/css')
async def css(req: Request):
    return templates.TemplateResponse('practice/css.html', {'request': req})