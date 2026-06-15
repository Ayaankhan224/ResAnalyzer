ResAnalyzer
Intelligent Candidate Ranking Engine

ResAnalyzer ranks candidates from a large JSONL dataset against a Job Description.
It does not match keywords. It evaluates dimensions.
Team: 99 Little Bugs
Team Members: Ayaan Khan (Leader)
              Shrestha S Gupta
              Mohd. Fazal
              Avi Saxena

---

What It Does ?

Recruiters screening thousands of applications face a real problem: manual review is slow, inconsistent, and easy to game with keyword stuffing. ResAnalyzer solves this by building a weighted scoring model on top of actual candidate signals, then generating a ranked shortlist with plain-English reasoning for every decision.
Give it a candidates.jsonl file and a target JD. It returns a submission.csv with the top 100 candidates, their composite scores, and recruiter-readable explanations of why each one ranked where it did.

---

Scoring Model:
Candidates are evaluated across two categories: technical signals and behavioral signals.
Technical signals
Years of experience (preferred range: 5 to 9 years)
Search engineering background
Information retrieval and ranking model experience
Recommendation systems exposure
Vector database knowledge (Milvus, Pinecone, Qdrant, FAISS, Weaviate)
AI and ML skills (NLP, LLMs, LoRA, Transformers)
Behavioral signals
Open to work status
Recruiter response rate
GitHub activity
Profile completeness
Notice period length
Penalties
Long notice periods reduce the score
Inactive profiles reduce the score
Irrelevant current roles reduce the score
Each signal carries a weight. High-weight signals drive the final rank. Penalties subtract proportionally. The result is a composite score that reflects real-world recruiter priorities, not just surface-level keyword overlap.

---

Explainability
Every ranked candidate gets a reasoning statement derived only from their profile data. No generated facts, no assumptions, no hallucinations.
Example output:
"7.8 years experience as Search Engineer at Google. Demonstrated experience in production search systems, retrieval systems, ranking models, and embedding-based retrieval."
Recruiters can cross-check every statement against the source profile. The reasoning is transparent by design.

---

Architecture
candidates.jsonl -> Candidate Loader -> Feature Extraction -> Scoring Engine -> Ranking Engine -> Reasoning Generator -> CSV Generator -> submission.csv
API layer: GET /api/rank triggers the full pipeline and writes submission.csv.
Components
candidateLoader.js streams the JSONL file using Node's readline API, so memory usage stays flat regardless of dataset size
scoringService.js applies the weighted framework across all signal dimensions
Ranking controller sorts candidates by composite score in descending order
csvGenerator.js writes the top 100 to a structured CSV with candidate_id, rank, score, and reasoning

---

Tech Stack
Node.js + Express.js for the backend API
JSONL streaming via readline and the native File System module
csv-writer for output generation
cors and dotenv for configuration
nodemon for development

No GPU required. No external ML infrastructure. The entire pipeline runs on a standard Node.js process.

---

Output Format
The submission.csv contains four columns:
candidate_id: unique identifier from the source dataset
rank: position in the final shortlist (1 to 100)
score: composite weighted score
reasoning: plain-English explanation of the ranking decision

---

Performance
Processes 100,000 candidate profiles per run
Memory-efficient streaming, no full dataset loaded into memory
Fast execution on standard hardware
Top candidates consistently show search engineering backgrounds, retrieval and ranking experience, and vector database exposure

---

Running Locally
Clone the repository
git clone https://github.com/your-org/resanalyzer.git
cd resanalyzer
Install dependencies
npm install
Add your dataset
Place your candidates.jsonl file inside the data/ directory.
Start the server
npm run dev
Trigger ranking
GET http://localhost:3000/api/rank
This runs the full pipeline and writes submission.csv to the output directory.

---

Future Work
LLM-based semantic resume analysis for deeper signal extraction
ML ranking models trained on historical recruiter decisions
Recruiter dashboard with filter and drill-down
Real-time ranking updates as new candidates are added
Candidate-to-JD matching across multiple open roles simultaneously

---
