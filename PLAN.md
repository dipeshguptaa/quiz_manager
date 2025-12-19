# Quiz Management System - PLAN

## Assumptions
- Admin Access is protected via HTTP Basic Authentication
- Quiz takers will be anonymous (no user Account)
- Quizzes can be published/unpublished
- Results are shown immediately after submission
- Supported question_types:
    - Multiple Choice (MCQ)
    - True/False
    - Short Text
- Admin can view all Submissions

## MVP Features

### Admin Panel
- create, edit, delete quizzes
- Add and manange qusetions within a quiz
- Support MCQ, True/False, and Short Text questions
- Publish/unpublish quizzes
- View Quiz submissions and results

### Public Interface
- List Published quizzes
- Take a Quiz
- Submit Answers
- View score and correct answers immediately

## Architecture

### Models

**Quiz**
- title (string)
- description (text)
- published (boolean)

**Question**
- quiz_id (foreign key)
- question_text (text)
- question_type (enum: mcq, true_false, short_text)
- correct_option_id (foreign key -> options.id, nullable)
- position (integer)

**Options**
- question_id (foreign key)
- content (string)

**Submission**
- quiz_id (foreign key)
- score (integer)
- total_questions (integer)
- submitted_at (datetime)

**Answer**
- submission_id (foreign key)
- question_id (foreign key)
- option_id (foreign key -> options.id, nullable)
- answer_text (text, for short text answers)
- is_correct (boolean)


## Routes Structure

/admin
- quizzes
- quizzes/:id/questions
- submissions

/public
- quizzes
- quizzes/:id
- quizzes/:id/submissions
- submissions/:id
