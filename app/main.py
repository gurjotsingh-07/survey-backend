from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from typing import List, Dict
from .database import get_db
from . import models, schemas
import logging
from sqlalchemy.orm import joinedload


logging.basicConfig(level=logging.DEBUG)


app = FastAPI()

# Allow your frontend to connect to the backend
origins = ["http://localhost:3000"]  # Replace with your React app's URL in production

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Get all surveys
@app.get("/api/surveys", response_model=List[schemas.SurveyResponse])
async def get_all_surveys(db: Session = Depends(get_db)):
    try:
        surveys = db.query(models.Survey).all()
        return surveys
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    

# Get unpublished surveys
@app.get("/api/surveys/unpublished", response_model=List[schemas.SurveyResponse])
async def get_unpublished_surveys(db: Session = Depends(get_db)):
    try:
        surveys = db.query(models.Survey).filter(models.Survey.status == schemas.SurveyStatus.DRAFT).all()
        return surveys
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Get a specific survey and its questions
@app.get("/api/surveys/{survey_id}", response_model=schemas.SurveyDetail)
async def get_survey(survey_id: int, db: Session = Depends(get_db)):
    try:
        survey = db.query(models.Survey).options(
            joinedload(models.Survey.questions).joinedload(models.Question.options)
        ).filter(models.Survey.id == survey_id).first()
        
        if not survey:
            raise HTTPException(status_code=404, detail="Survey not found")
        
        return survey
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Get responses for a specific survey
@app.get("/api/responses/{survey_id}", response_model=List[schemas.Response])
async def get_survey_responses(survey_id: int, db: Session = Depends(get_db)):
    try:
        responses = db.query(models.Response).filter(models.Response.survey_id == survey_id).all()
        if not responses:
            raise HTTPException(status_code=404, detail="No responses found for this survey")
        return responses
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Get questions (deduplicated by text and type)
@app.get("/api/questions", response_model=List[schemas.QuestionResponse])
async def get_questions(db: Session = Depends(get_db)):
    try:
        questions = db.query(models.Question).distinct(models.Question.text, models.Question.type).all()
        return questions
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))





# Create a new survey
@app.post("/api/surveys", response_model=schemas.SurveyResponse)
async def create_survey(survey: schemas.SurveyCreate, db: Session = Depends(get_db)):

    logging.debug(f"Received survey object: {survey}")

    try:
        db_survey = models.Survey(
            user_id=survey.user_id,
            title=survey.title,
            description=survey.description,
            status=survey.status,
            start_date=survey.start_date,
            end_date=survey.end_date,
            total_responses=0,  
            total_people_sent=0
        )
        db.add(db_survey)
        db.commit()
        db.refresh(db_survey)

        # Loop through questions and add options for radio/checkbox questions
        for question in survey.questions:
            db_question = models.Question(
                survey_id=db_survey.id,
                text=question.text,
                type=question.type,
                required=question.required
            )
            db.add(db_question)
            db.commit()  # Commit here to get the question's id
            db.refresh(db_question)  # Ensure we get the fresh question id

            # If the question type is radio or checkbox, add options
            logging.debug(f"Received survey object: {question}")
            logging.debug(f"checking option: {models.QuestionType.RADIO}")
            if question.type in [models.QuestionType.RADIO, models.QuestionType.CHECKBOX]:
                logging.debug(f"Entered here: {question}")
                for option in question.options:
                    db_option = models.Option(
                        question_id=db_question.id,
                        text=option.text
                    )
                    db.add(db_option)

        db.commit()  # Commit changes for options

        return db_survey
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# Submit a response to a survey
@app.post("/api/responses", response_model=schemas.Response)
async def submit_response(response: schemas.ResponseCreate, db: Session = Depends(get_db)):
    try:
        # Create a new response record
        db_response = models.Response(
            survey_id=response.survey_id,
            respondent_id=response.respondent_id
        )
        db.add(db_response)
        db.commit()
        db.refresh(db_response)

        # Add the answers for the response
        for question_id, answer_data in response.answers.items():
            db_answer = models.Answer(
                response_id=db_response.id,
                question_id=question_id,
                answer_text=answer_data.get("text"),
                option_id=answer_data.get("option_id")
            )
            db.add(db_answer)
        db.commit()

        # Increment the total_responses field for the survey
        db.query(models.Survey).filter(models.Survey.id == response.survey_id).update(
            {"total_responses": models.Survey.total_responses + 1},
            synchronize_session=False
        )
        db.commit()

        return db_response
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# Publish a survey
@app.post("/api/surveys/publish", response_model=Dict[str, str])
async def publish_survey(publish_data: schemas.SurveyPublish, db: Session = Depends(get_db)):
    try:
        # Get the survey to be published
        survey = db.query(models.Survey).filter(models.Survey.id == publish_data.survey_id).first()
        if not survey:
            raise HTTPException(status_code=404, detail="Survey not found")

        # Set the survey status to ACTIVE and set start/end dates
        survey.status = schemas.SurveyStatus.ACTIVE
        survey.start_date = publish_data.start_date
        survey.end_date = publish_data.end_date

        # Determine the users to whom the survey will be sent (e.g., based on team)
        # if publish_data.team_id:
        #     users = db.query(models.User).filter(models.User.team_id == publish_data.team_id).all()
        # else:
        #     users = db.query(models.User).all()

        # Update the total_people_sent field with the number of users
        # survey.total_people_sent = len(users)

        db.commit()

        return {"message": "Survey published successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

