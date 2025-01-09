from sqlalchemy import (
    Column, Integer, String, Text, Enum, Boolean, DateTime, ForeignKey
)
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
import enum
from datetime import datetime

Base = declarative_base()

# Enums for status and question types
class SurveyStatus(enum.Enum):
    DRAFT = "DRAFT"
    ACTIVE = "ACTIVE"
    CLOSED = "CLOSED"

class QuestionType(enum.Enum):
    TEXT = "TEXT"
    CHECKBOX = "CHECKBOX"
    RADIO = "RADIO"
    DROPDOWN = "DROPDOWN"

# User Model
class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    name = Column(String(255), nullable=False)
    email = Column(String(255), unique=True, nullable=False, index=True)
    password_hash = Column(String(255), nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    surveys = relationship("Survey", back_populates="user")

# Survey Model
class Survey(Base):
    __tablename__ = "surveys"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    title = Column(String(255), nullable=False)
    description = Column(Text)
    status = Column(Enum(SurveyStatus), default=SurveyStatus.DRAFT)
    start_date = Column(DateTime, nullable=True)
    end_date = Column(DateTime, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    total_responses = Column(Integer)
    total_people_sent = Column(Integer)


    user = relationship("User", back_populates="surveys")
    questions = relationship("Question", back_populates="survey")
    responses = relationship("Response", back_populates="survey")

# Question Model
class Question(Base):
    __tablename__ = "questions"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    survey_id = Column(Integer, ForeignKey("surveys.id", ondelete="CASCADE"), nullable=False)
    text = Column(Text, nullable=False)
    type = Column(Enum(QuestionType), nullable=False)
    required = Column(Boolean, default=False)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    survey = relationship("Survey", back_populates="questions")
    options = relationship("Option", back_populates="question")
    answers = relationship("Answer", back_populates="question")

# Option Model
class Option(Base):
    __tablename__ = "options"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    question_id = Column(Integer, ForeignKey("questions.id", ondelete="CASCADE"), nullable=False)
    text = Column(String(255), nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    question = relationship("Question", back_populates="options")

# Respondent Model
class Respondent(Base):
    __tablename__ = "respondents"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    email = Column(String(255), nullable=True)
    name = Column(String(255), nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

    responses = relationship("Response", back_populates="respondent")

# Response Model
class Response(Base):
    __tablename__ = "responses"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    survey_id = Column(Integer, ForeignKey("surveys.id", ondelete="CASCADE"), nullable=False)
    respondent_id = Column(Integer, ForeignKey("respondents.id", ondelete="SET NULL"), nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

    survey = relationship("Survey", back_populates="responses")
    respondent = relationship("Respondent", back_populates="responses")
    answers = relationship("Answer", back_populates="response")

# Answer Model
class Answer(Base):
    __tablename__ = "answers"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    response_id = Column(Integer, ForeignKey("responses.id", ondelete="CASCADE"), nullable=False)
    question_id = Column(Integer, ForeignKey("questions.id", ondelete="CASCADE"), nullable=False)
    answer_text = Column(Text, nullable=True)
    option_id = Column(Integer, ForeignKey("options.id", ondelete="SET NULL"), nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

    response = relationship("Response", back_populates="answers")
    question = relationship("Question", back_populates="answers")
