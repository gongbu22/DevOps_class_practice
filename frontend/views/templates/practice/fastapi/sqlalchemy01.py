from typing import List, Optional

from fastapi import FastAPI
from fastapi.params import Depends
from pydantic import BaseModel
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import sessionmaker, declarative_base, Session

sqlite_url = 'sqlite:///python.db'
engine = create_engine(sqlite_url, connect_args={'check_same_thread': False}, echo=True)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

class Sungjuk(Base):
    __tablename__ = 'sungjuk'

    sjno = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    kor = Column(Integer)
    eng = Column(Integer)
    mat = Column(Integer)

Base.metadata.create_all(bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# pydantic 모델
class SungjukModel(BaseModel):
    sjno: int
    name: str
    kor: int
    eng: int
    mat: int

app = FastAPI()

@app.get('/')
def index():
    return 'Hello, SQLAlchemy!!'

# 성적 조회
@app.get('/sj', response_model=List[SungjukModel])
def read_sj(db: Session = Depends(get_db)):
    sungjuks = db.query(Sungjuk).all()
    return sungjuks

# 성적 추가
@app.post('/sj', response_model=SungjukModel)
def sjadd(sj: SungjukModel, db: Session = Depends(get_db)):
    sj = Sungjuk(**dict(sj))
    db.add(sj)
    db.commit()
    db.refresh(sj)
    return sj

# 성적 상세조회
@app.get('/sj/{sjno}', response_model=Optional[SungjukModel])
def readone_sj(sjno: int, db: Session = Depends(get_db)):
    sungjuks = db.query(Sungjuk).filter(Sungjuk.sjno == sjno).first()
    return sungjuks

# 성적 삭제
@app.delete('/sj/{sjno}', response_model=Optional[SungjukModel])
def delete_sj(sjno: int, db: Session = Depends(get_db)):
    sungjuk = db.query(Sungjuk).filter(Sungjuk.sjno == sjno).first()
    if sungjuk:
        db.delete(sungjuk)
        db.commit()
    return sungjuk

# 성적 수정
@app.put('/sj', response_model=Optional[SungjukModel])
def update_sj(sj: SungjukModel, db: Session = Depends(get_db)):
    sungjuk = db.query(Sungjuk).filter(Sungjuk.sjno == sj.sjno).first()
    if sungjuk:
        for key, val in sj.dict().items():
            setattr(sungjuk, key, val)
        db.commit()
        db.refresh(sungjuk)
    return sungjuk

if __name__ == '__main__':
    import uvicorn
    uvicorn.run('sqlalchemy01:app', reload=True)
