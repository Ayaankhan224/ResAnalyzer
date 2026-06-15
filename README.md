ResAnalyzer
Intelligent Candidate Ranking Engine

ResAnalyzer ranks candidates from a large JSONL dataset against a Job Description.
It does not match keywords. It evaluates dimensions.
Team: 99 Little Bugs

Team Members: 

a) Ayaan Khan (Leader)              
b) Shrestha S Gupta

c) Mohd. Fazal
d) Avi Saxena

---

What It Does ?

Recruiters screening thousands of applications face a real problem: manual review is slow, inconsistent, and easy to game with keyword stuffing. ResAnalyzer solves this by building a weighted scoring model on top of actual candidate signals, then generating a ranked shortlist with plain-English reasoning for every decision.
Give it a candidates.jsonl file and a target JD. It returns a submission.csv with the top 100 candidates, their composite scores, and recruiter-readable explanations of why each one ranked where it did.

---

Scoring Model:

1) Candidates are evaluated across two categories: technical signals and behavioral signals.
2) Technical signals
3) Years of experience (preferred range: 5 to 9 years)
4) Search engineering background
5) Information retrieval and ranking model experience
6) Recommendation systems exposure
7) Vector database knowledge (Milvus, Pinecone, Qdrant, FAISS, Weaviate)
8) AI and ML skills (NLP, LLMs, LoRA, Transformers)
9) Behavioral signals
10) Open to work status
11) Recruiter response rate
12) GitHub activity
13) Profile completeness
14) Notice period length
15) Penalties
16) Long notice periods reduce the score
17) Inactive profiles reduce the score
18) Irrelevant current roles reduce the score
19) Each signal carries a weight. High-weight signals drive the final rank. Penalties subtract proportionally. The result is a composite score that reflects real-world recruiter priorities, not just surface-level keyword overlap.

---

Explainability:

a) Every ranked candidate gets a reasoning statement derived only from their profile data. No generated facts, no assumptions, no hallucinations.
Example output:
"7.8 years experience as Search Engineer at Google. Demonstrated experience in production search systems, retrieval systems, ranking models, and embedding-based retrieval."
b) Recruiters can cross-check every statement against the source profile. The reasoning is transparent by design.

---

Architecture:

1) candidates.jsonl -> Candidate Loader -> Feature Extraction -> Scoring Engine -> Ranking Engine -> Reasoning Generator -> CSV Generator -> submission.csv
2) API layer: GET /api/rank triggers the full pipeline and writes submission.csv.
   
Components:

1) candidateLoader.js streams the JSONL file using Node's readline API, so memory usage stays flat regardless of dataset size.
2) scoringService.js applies the weighted framework across all signal dimensions.
3) Ranking controller sorts candidates by composite score in descending order.
4) csvGenerator.js writes the top 100 to a structured CSV with candidate_id, rank, score, and reasoning.

---

Tech Stack:

a) Node.js + Express.js for the backend API.
b) JSONL streaming via readline and the native File System module.
c) csv-writer for output generation.
d) cors and dotenv for configuration.
e) nodemon for development.

No GPU required. No external ML infrastructure. The entire pipeline runs on a standard Node.js process.

---

Output Format:

1) The submission.csv contains four columns:
2) candidate_id: unique identifier from the source dataset
3) rank: position in the final shortlist (1 to 100)
4) score: composite weighted score
5) reasoning: plain-English explanation of the ranking decision

---

Performance:

a) Processes 100,000 candidate profiles per run
b) Memory-efficient streaming, no full dataset loaded into memory
c) Fast execution on standard hardware
d) Top candidates consistently show search engineering backgrounds, retrieval and ranking experience, and vector database exposure

---

Running Locally:

1) Clone the repository
2) git clone https://github.com/your-org/resanalyzer.git
3) cd resanalyzer
4) Install dependencies
5) npm install
6) Add your dataset
7) Place your candidates.jsonl file inside the data/ directory.
8) Start the server
9) npm run dev
10) Trigger ranking
11) GET http://localhost:3000/api/rank
    
This runs the full pipeline and writes submission.csv to the output directory.

---

Future Work:

a) LLM-based semantic resume analysis for deeper signal extraction
b) ML ranking models trained on historical recruiter decisions
c) Recruiter dashboard with filter and drill-down
d)Real-time ranking updates as new candidates are added
e) Candidate-to-JD matching across multiple open roles simultaneously

---
