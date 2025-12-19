# Quiz Management System - PLAN

## Assumptions
- Admin access is protected via HTTP Basic Authentication
- Quiz takers will be anonymous (no user accounts)
- Quizzes can be created in published/draft state
- A quiz can be published only if it has at least one question
- Only published quizzes are visible to the public
- Results are shown immediately after submission
- Supported question_types:
  - Multiple Choice (MCQ)
  - True / False
  - Short Text
- Admin can view all submissions and answers

---

## MVP Features

### Admin Panel
- Create, edit, delete quizzes
- Add, edit, delete questions within a quiz
- Questions are managed inside the quiz detail page
- Support MCQ, True/False, and Short Text questions
- Publish / unpublish quizzes
  - Publishing is blocked if the quiz has no questions
- View quiz submissions and results

---

### Public Interface
- List published quizzes only
- View quiz details
- Take a quiz
- Submit answers
- View score and correct answers immediately after submission
- Redirect to quiz list with an error if quiz is unpublished or not found

---

## Architecture

### Models

**Quiz**
- title (string)
- description (text)
- published (boolean, default: false)

Rules:
- Quiz can exist without questions
- Quiz cannot be published unless it has at least one question

---

**Question**
- quiz_id (foreign key)
- question_text (text)
- question_type (enum: mcq, true_false, short_text)
- correct_option_id (foreign key -> options.id, nullable)
- position (integer)

---

**Option**
- question_id (foreign key)
- content (string)

---

**Submission**
- quiz_id (foreign key)
- score (integer)
- total_questions (integer)
- submitted_at (datetime)

---

**Answer**
- submission_id (foreign key)
- question_id (foreign key)
- option_id (foreign key -> options.id, nullable)
- answer_text (text, for short text answers)
- is_correct (boolean)

---

## Routes Structure

### Admin Routes
/admin
- quizzes
  - index
  - new
  - create
  - show (includes questions listing)
  - edit
  - update
  - destroy
- quizzes/:quiz_id/questions
  - new
  - create
  - edit
  - update
  - destroy
- submissions

Note:
- No separate index for questions
- Questions are displayed within the quiz show page

---

### Public Routes
/public
- quizzes
  - index (published quizzes only)
  - show (only if quiz is published)
- quizzes/:id/submissions
  - create
- submissions/:id
  - show (results)

---

## Scope Changes During Implementation
- Moved question listing from a separate index page to the quiz show page for better UX
- Added validation to ensure quizzes cannot be published without at least one question
- Introduced strict access control to prevent public access to unpublished quizzes
- Improved error handling and user feedback for invalid or restricted quiz access

---

## Reflection & Next Steps
If more time were available, the following enhancements would be prioritized:

- Introduce a **User** model with login/signup functionality
  - Role-based access (Admin, Creator)
- Add quiz scheduling features:
  - Start date and start time
  - Quiz duration with automatic submission on timeout
- Add attempt limits per quiz
- Support negative marking and partial scoring
- Add analytics and reports for quiz performance
- Improve UI with progress indicators and autosave
