from typing import List

from fastapi import FastAPI
from pydantic import BaseModel


class Sungjuk(BaseModel):
    name: str
    kor: int
    eng: int
    mat: int

sungjuk_db:List[Sungjuk] = []

app = FastAPI()

@app.get('/')
def sayhello():
    return 'Hello World!'

# 성적 조회
@app.get('/sj', response_model=List[Sungjuk])
def sj_readall():
    return sungjuk_db

# 성적 추가
@app.post('/sjadd', response_model=Sungjuk)
def sj_create(sj: Sungjuk):
    sungjuk_db.append(sj)
    return sj

# 샘플데이터 추가
@app.get('/sjadd', response_model=Sungjuk)
def sj_create_get():
    sj = Sungjuk(name='haha', kor=34, eng=45, mat=78)
    sungjuk_db.append(sj)

    sj = Sungjuk(name='kiki', kor=77, eng=66, mat=99)
    sungjuk_db.append(sj)

    sj = Sungjuk(name='happy', kor=67, eng=54, mat=92)
    sungjuk_db.append(sj)

    return sj

# 성적 상세 조회
@app.get('/sj/{name}', response_model=Sungjuk)
def sj_readone(name: str):
    findone = Sungjuk(name='none', kor=00, eng=00, mat=00)
    for sj in sungjuk_db:
        if sj.name == name:
            findone = sj
    return findone

# 성적 수정
@app.put('/sj', response_model=Sungjuk)
def sj_modify(one: Sungjuk):
    putone = Sungjuk(name='none', kor=00, eng=00, mat=00)
    for idx, sj in enumerate(sungjuk_db):
        if sj.name == one.name:
            sungjuk_db[idx] = one
            putone = one
    return putone

# 성적 삭제
@app.delete('/sj/{name}', response_model=Sungjuk)
def sj_delete(name: str):
    rmvone = Sungjuk(name='none', kor=00, eng=00, mat=00)
    for idx, sj in enumerate(sungjuk_db):
        if sj.name == name:
            rmvone = sungjuk_db.pop(idx)
    return rmvone

if __name__ == '__main__':
    import uvicorn
    uvicorn.run('pydantic01:app', reload=True)