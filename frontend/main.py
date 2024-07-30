from fastapi import FastAPI,Request
from starlette.responses import HTMLResponse
from starlette.staticfiles import StaticFiles
from starlette.templating import Jinja2Templates

from frontend.app.routes.board import board_router
from frontend.app.routes.member import member_router

app = FastAPI()
templates = Jinja2Templates(directory='views/templates')
app.mount('/static', StaticFiles(directory='views/static'), name='static')

app.include_router(member_router, prefix='/member')
app.include_router(board_router, prefix='/board')

@app.get('/', response_class=HTMLResponse)
async def index(req: Request):
    return templates.TemplateResponse('index.html', {'request': req})
