# 🦾 FitOS — The Personal AI Operating System for Physical Optimization

FitOS is a next-generation, deeply engaging fitness platform that fuses predictive AI, behavioral psychology, and high-performance UI/UX. It evolves the standard "workout tracker" into an active, predictive engine for biomechanical optimization.

## 🎯 The Mission
To obliterate passive trackers by providing an immersive, insight-driven experience. FitOS uses Retrieval-Augmented Generation (RAG) and vector similarity to remember your history, injuries, and preferences, providing actionable predictive insights.

---

## 🧬 Core Feature: Intelligent Exercise Ontology
The backbone of FitOS is a mathematically structured, multi-dimensional database of human movement.

### 🔄 3-Stage Substitution Pipeline
Our `SubstitutionService` ensures you never miss a beat in the gym, even when equipment is occupied:
1.  **Stage 1: Hard-Stop Filter (Safety)**
    *   Excludes exercises based on `injuredMuscleIds`.
    *   Respects equipment availability and explicit blacklists.
2.  **Stage 2: Vector Similarity (Biomechanical)**
    *   Uses `sqlite-vec` for cosine similarity on 9+1 ontological dimensions.
    *   Dimensions include: Movement Pattern, Angle, Laterality, Loading Type, Skill Level, Mechanics, and CNS Cost.
3.  **Stage 3: Personalization Bias (Human Element)**
    *   Boosts preferred exercises and penalizes sore muscle groups dynamically.

---

## 🦄 3D Anatomical Visual Twin (The "Dragon" Interface)
An immersive 3D muscle map that visualizes real-time biomechanical feedback.
- **Dynamic Hotspots:** Reactive neon points visualizing muscle fatigue (ACWR).
- **Interactive GLB:** High-performance 3D model viewer for intuitive anatomy exploration.
- **Biomechanical Radar:** Identifying muscle imbalances and CNS readiness at a glance.

---

## 🛠️ Technical Infrastructure
- **Framework:** Flutter (3.29.0+)
- **Local Storage:** Drift (SQLite) + `sqlite-vec` for offline vector search.
- **State Management:** Riverpod (Functional Providers).
- **3D Engine:** `model_viewer_plus` (GLB/GLTF).
- **Cloud:** Supabase (PostgreSQL + pgvector) for global sync and AI-metadata inference.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.29.0+)
- Android SDK (with NDK licenses accepted)
- `sqlite-vec` native extensions (bundled with app)

### Setup
1.  **Clone the repository**
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Generate code:**
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
4.  **Run the app:**
    ```bash
    flutter run
    ```

---

## 📈 Roadmap
- [x] **Phase 1-4:** Core Ontology & Vector search.
- [x] **Phase 5:** Personalization layer (Injury detection & Bias).
- [x] **3D Twin:** Interactive anatomical model integration.
- [ ] **Phase 6:** Global Data Flywheel (Sync & Promotion).

---
*FitOS is built with absolute priority on visual excellence and zero-friction interaction. Be better, faster.*
