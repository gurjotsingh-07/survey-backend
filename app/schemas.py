from pydantic import BaseModel, EmailStr
from typing import Optional, List, Dict
from datetime import datetime
import enum

# Enums for Pydantic
class SurveyStatus(str, enum.Enum):
    DRAFT = "DRAFT"
    ACTIVE = "ACTIVE"
    CLOSED = "CLOSED"

class QuestionType(str, enum.Enum):
    TEXT = "TEXT"
    CHECKBOX = "CHECKBOX"
    RADIO = "RADIO"
    DROPDOWN = "DROPDOWN"

# User Schema
class UserBase(BaseModel):
    name: str
    email: EmailStr

class UserCreate(UserBase):
    password: str

class UserResponse(UserBase):
    id: int
    created_at: datetime

    class Config:
        orm_mode = True

# Survey Schema
class SurveyBase(BaseModel):
    title: str
    description: Optional[str] = None
    status: SurveyStatus
    start_date: Optional[datetime]
    end_date: Optional[datetime]

class SurveyCreate(SurveyBase):
    user_id: int
    questions: List['QuestionCreate']
    class Config:
        use_enum_values = True  # This forces enums to serialize as their string values


class SurveyResponse(SurveyBase):
    id: int
    created_at: datetime
    updated_at: datetime
    total_responses: int
    total_people_sent: int

    class Config:
        orm_mode = True

class SurveyDetail(SurveyResponse):
    questions: List['QuestionResponse']

# Option Schema
class OptionBase(BaseModel):
    text: str

class OptionCreate(OptionBase):
    question_id: int

class OptionResponse(OptionBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True

# Question Schema
class QuestionBase(BaseModel):
    text: str
    type: QuestionType
    required: bool

class QuestionResponse(QuestionBase):
    id: int
    created_at: datetime
    updated_at: datetime
    survey_id: int
    options: List[OptionResponse] = []

    class Config:
        orm_mode = True


class QuestionCreate(QuestionBase):
    options: Optional[List[OptionBase]] = []
    class Config:
        use_enum_values = True  # This forces enums to serialize as their string values


# Respondent Schema
class RespondentBase(BaseModel):
    email: Optional[EmailStr] = None
    name: Optional[str] = None

class RespondentResponse(RespondentBase):
    id: int
    created_at: datetime

    class Config:
        orm_mode = True

# Response Schema
class ResponseBase(BaseModel):
    survey_id: int
    respondent_id: Optional[int]

class ResponseCreate(ResponseBase):
    answers: Dict[int, Dict[str, Optional[str]]]

class Response(ResponseBase):
    id: int
    created_at: datetime

    class Config:
        orm_mode = True

# SurveyPublish Schema
class SurveyPublish(BaseModel):
    survey_id: int
    start_date: datetime
    end_date: datetime
