from sqlalchemy.orm import Session
from . import models, schemas

def create_survey(db: Session, survey: schemas.SurveyCreate):
    db_survey = models.Survey(**survey.dict())
    db.add(db_survey)
    db.commit()
    db.refresh(db_survey)
    return db_survey

def get_survey(db: Session, survey_id: int):
    return db.query(models.Survey).filter(models.Survey.id == survey_id).first()

def get_surveys(db: Session, skip: int = 0, limit: int = 10):
    return db.query(models.Survey).offset(skip).limit(limit).all()
