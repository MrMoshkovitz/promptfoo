# Grounded Progressive Architecture: A Design Methodology for Human-AI Collaborative Software Development

**Authors:**
- Eliran Sabag (eliran.sbg@gmail.com)
- Gal Moshkovitz (https://www.linkedin.com/in/gal-moshkovitz/)

**Abstract**

As Large Language Models (LLMs) become integral to software development, traditional design methodologies prove inadequate for human-AI collaboration. This paper introduces Grounded Progressive Architecture (GPA), a five-phase design methodology optimized for maintaining focus and coherence during AI-assisted solution development. Through analysis of a real-world case study, we demonstrate how GPA leverages AI capabilities while preserving human agency and preventing scope drift. The methodology addresses key challenges in human-AI collaboration: information overload, decision paralysis, and loss of architectural vision during iterative refinement.

**Keywords**: Human-AI Collaboration, Software Architecture, Design Methodology, Large Language Models, Decision Making

## 1. Introduction

The emergence of sophisticated AI coding assistants has fundamentally altered software development workflows. While these tools excel at pattern recognition, code generation, and comprehensive analysis, they introduce new challenges: infinite solution possibilities, analysis paralysis, and dilution of architectural vision through feature creep.

Traditional design methodologies like Design Thinking and Agile development were created for purely human teams. They assume limited information processing capacity and focus on overcoming human cognitive limitations. In contrast, human-AI collaboration suffers from the opposite problem: too much information, too many possibilities, and insufficient filtering mechanisms.

This paper presents Grounded Progressive Architecture (GPA), a methodology specifically designed for human-AI collaborative software development. GPA addresses the unique challenges of maintaining architectural coherence while leveraging AI's analytical capabilities.

## 2. Background and Related Work

### 2.1 Traditional Design Methodologies

Design Thinking emphasizes empathy, ideation, and prototyping but lacks mechanisms for managing AI-generated complexity. Agile methodologies focus on iterative development but don't address the philosophical grounding needed to filter infinite AI-suggested possibilities.

### 2.2 Human-AI Collaboration Challenges

Research in human-AI collaboration identifies several recurring problems:
- **Information Overload**: AI can generate unlimited alternatives, leading to decision paralysis
- **Scope Drift**: AI's comprehensive analysis often expands project scope beyond original intent  
- **Loss of Vision**: Iterative AI feedback can dilute original architectural insights
- **Agency Confusion**: Unclear boundaries between human judgment and AI recommendation
- **Attention Fragmentation**: LLMs are trained to satisfy the latest prompt, creating cognitive ADHD-like behavior that can lose track of earlier vision

### 2.3 The Need for New Methodologies

Existing frameworks assume human-bounded rationality but fail to address AI-bounded context. A methodology optimized for human-AI collaboration must leverage AI's strengths while preserving human architectural vision and decision authority.

## 3. The Grounded Progressive Architecture Methodology

GPA consists of five distinct phases, each optimized for specific aspects of human-AI collaboration, with critical implementation principles woven throughout:

### Phase 1: Concrete Vision Casting

**Objective**: Establish a tangible, implementable solution sketch before engaging AI assistance.

**Process**:
- Define specific problem with concrete solution outline
- Avoid abstract goals or open-ended problem statements  
- Present AI with structured, examnable proposition
- Explicitly defer implementation details
- **Critical**: Use strategic naming that focuses AI attention on mission

**Rationale**: AI systems excel at analysis and extension but struggle with vision generation from abstract requirements. Starting with concrete vision gives AI productive analytical targets while preserving human creative authority.

**Anti-patterns**: 
- "How should I build X?" (too open-ended)
- "What's the best way to solve Y?" (invites generic solutions)

**Preferred pattern**: "I want to build X that does A, B, C. Don't code anything, think about it."

**Key Principle**: Naming matters profoundly. The project name becomes a cognitive anchor that keeps AI focused on the core mission throughout all subsequent interactions.

### Phase 2: Iterative Deepening Pattern

**Objective**: Systematically evolve the initial vision through structured refinement cycles while maintaining architectural coherence.

**Process**:
- Present evolved concept based on initial vision
- Invite AI analysis and extensions
- **Critical**: Process AI feedback internally according to established principles
- Return with evolved but coherent vision
- Repeat cycle until architectural completeness achieved
- **Hard Blocking**: Never proceed to next phase until completely satisfied with current iteration

**Rationale**: This addresses the fundamental challenge of AI collaboration - leveraging comprehensive analytical capabilities while preventing vision dilution. Each cycle adds sophistication without losing the core insight.

**Implementation Rules**:
- **Message Editing Protocol**: Always edit and refine messages rather than continuing explanation in subsequent prompts
- **Phase Blocking**: Complete satisfaction with current phase is mandatory before progression
- **Token Economy**: Every word counts - think carefully about each response as you're dealing with "The Butterfly Effect"

### Phase 3: Collaborative Stress Testing

**Objective**: Systematically surface concerns, edge cases, and implementation challenges through AI analysis.

**Process**:
- Explicitly invite AI to identify problems and limitations
- Resist immediate problem-solving; focus on problem collection
- Encourage exploration of failure modes and complexity sources
- Document all concerns without filtering
- **Critical**: Avoid arguing with AI to make it understand better - this causes faster vision loss

**Rationale**: Human architects often suffer from confirmation bias and blind spots. AI's pattern-matching capabilities can identify issues that human intuition misses. However, this phase must remain diagnostic rather than prescriptive.

**Key Principle**: Flood problems, don't fix them yet. Remember that instruction-tuned LLMs want to satisfy your latest prompt - maintain focus through consistent messaging.

### Phase 4: Philosophical Grounding

**Objective**: Establish decision-making principles that filter subsequent choices and maintain architectural coherence.

**Process**:
- Identify core values and principles underlying the solution
- Connect technical choices to human-centered philosophy
- Establish clear boundaries and non-negotiables
- Create decision-making framework for future trade-offs
- **Critical**: Articulate philosophy clearly to provide consistent decision criteria

**Rationale**: This phase transforms scattered technical concerns into coherent worldview. Philosophical grounding prevents both human and AI from getting lost in infinite optimization cycles by providing consistent decision criteria.

**Example**: The "My Way" principle in our case study became a lens for every subsequent architectural decision.

### Phase 5: Principled Boundary Setting

**Objective**: Use philosophical framework to make rapid, consistent scope decisions.

**Process**:
- Apply established principles to each identified concern
- Make decisive cuts to features that don't serve core vision
- Resist feature creep through principle-driven decisions
- Maintain focus on essential functionality
- **Final Implementation**: Create all deliverable files at once in a single prompt, not sequentially

**Rationale**: Without principled boundary setting, AI collaboration leads to scope explosion. Every AI-suggested improvement seems reasonable in isolation, but collectively they destroy focus and delay shipping.

**Decision Framework**: 
- Does this serve the core vision?
- Does this align with established principles?
- Is this essential for the primary use case?

**Implementation Principle**: The optimal process requires only 6-7 well-crafted prompts using message editing and phase blocking to achieve complete architectural specification.

### Phase 6: Meta-Cognitive Review

**Objective**: Analyze and improve the design process itself.

**Process**:
- Examine decision patterns and methodology effectiveness
- Identify reusable principles and process improvements
- Document methodology evolution for future projects
- Build conscious competence in human-AI collaboration

**Rationale**: Continuous process improvement prevents methodology stagnation and builds systematic capability for future human-AI design collaboration.

## 4. Case Study: The Sinatra Project

### 4.1 Project Context

The Sinatra project aimed to create an MCP memory server for AI-assisted architectural analysis. The project demonstrates GPA methodology through a complete design cycle from initial concept to implementation specification, executed in precisely seven prompts.

### 4.2 Phase 1 Application: Initial Vision

**Human Input**: "I want to design a mcp 'memory' server and agent. Once he scan a project (suppose python/JS/Typescript) he will make a networkx graph mapping all the project classes and modules... Don't code nothing, think about it."

**Analysis**: This opening demonstrates ideal concrete vision casting:
- Specific technology choices (MCP server, networkx graphs)
- Clear input/output specification (scan projects → generate graphs)
- Explicit deferral of implementation ("Don't code nothing")
- Concrete enough for AI analysis, abstract enough for iteration

### 4.3 Phase 2 Application: Iterative Deepening

**Evolution Cycle 1**: Adding runtime reality - "comparing trace log of failure to the graph to figure what's missing"

**Evolution Cycle 2**: The three-graph insight - Vision graph (with implement flags) + Codebase graph + Diff engine

**Pattern Analysis**: Each iteration added sophisticated layers while preserving the core insight. The human architect processed AI feedback internally, returning with evolved but coherent vision rather than design-by-committee dilution.

**Key Observation**: The deepening pattern prevented both stagnation (no AI input) and chaos (unfiltered AI expansion) through principled integration of feedback.

### 4.4 Phase 3 Application: Stress Testing

**AI Concerns Raised**:
- Version control complexity across git branches
- Team conflict resolution in collaborative environments
- Dynamic runtime behavior not captured by static analysis
- Evolution problems when vision conflicts with reality
- Cognitive load implications for developers

**Outcome**: Comprehensive problem identification without premature solution attempts, providing complete landscape of implementation challenges.

### 4.5 Phase 4 Application: Philosophical Grounding

**Human Response**: "No single point of truth (except one god), This is my vision, I did it my way... our job is to flood problems, might suggest but not fix and replace the developer."

**Analysis**: The "My Way" philosophy became the organizing principle:
- Respect for developer autonomy over architectural enforcement
- Advisory rather than prescriptive approach
- Focus on problem visibility rather than solution imposition
- Individual architectural sovereignty over universal best practices

### 4.6 Phase 5 Application: Boundary Setting

**Scope Decisions Made**:
- **Excluded**: Runtime configuration analysis ("too complicated")
- **Excluded**: Cross-service dependencies ("off scope")
- **Excluded**: Auto-fixing capabilities ("up to developer to decide")
- **Included**: Vision-codebase-trace triangulation (core value)

**Decision Pattern**: Each exclusion was justified by the "My Way" principle - features that would impose external authority were consistently rejected.

**Final Implementation**: All project files (vision, PRD, implementation specs, philosophy document) were generated in a single prompt, demonstrating the "create all at once" principle.

### 4.7 Phase 6 Application: Process Analysis

The request for this meta-analysis demonstrates the final phase: systematic examination of the design process itself to extract reusable methodology, completing the seven-prompt cycle that established the entire Sinatra system.

## 5. Critical Implementation Principles

### 5.1 The Message Editing Protocol

Traditional chat-based development leads to context drift and vision loss. GPA requires disciplined message editing rather than continuation prompting. This maintains focus and prevents the AI's natural tendency to satisfy only the latest request.

### 5.2 Phase Blocking Discipline

The methodology demands complete satisfaction with each phase before progression. This prevents rushing to implementation before achieving architectural clarity and ensures each phase delivers its intended value.

### 5.3 Token Economics and Butterfly Effect

Every word in human prompts carries weight in AI interpretation. Careless phrasing can derail entire architectural directions. GPA emphasizes careful, intentional communication that guides rather than confuses AI analysis.

### 5.4 The ADHD Challenge

Instruction-tuned LLMs exhibit attention patterns similar to severe ADHD - brilliant analytical capability combined with extreme distractibility. GPA's structured approach provides the consistency needed to maintain AI focus on architectural objectives.

### 5.5 Strategic Naming

Project names aren't cosmetic choices but cognitive anchors. "Sinatra" immediately evoked "My Way" philosophy, which then guided every subsequent decision. Strategic naming becomes a form of AI prompt engineering embedded in the project identity.

## 6. Discussion

### 6.1 Advantages of GPA

**Focus Preservation**: Philosophical grounding and principled boundary setting prevent scope drift that typically occurs in AI-assisted development.

**AI Utilization**: Each phase leverages AI's strengths (analysis, pattern recognition, comprehensive examination) while avoiding AI's weaknesses (vision generation, decision making, context understanding).

**Human Agency**: Maintains clear human decision authority throughout the process, preventing AI from inadvertently driving architectural choices.

**Efficiency**: The seven-prompt structure with message editing and phase blocking achieves complete architectural specification without waste or iteration cycles.

**Scalability**: The methodology works for projects of varying complexity, from simple tools to complex systems.

### 6.2 Limitations and Considerations

**Philosophical Dependency**: The methodology requires humans capable of articulating clear philosophical positions, which may not suit all developers or organizations.

**AI Quality Sensitivity**: Success depends on AI systems capable of comprehensive analysis and constraint recognition.

**Discipline Requirements**: The methodology demands strict adherence to phase blocking and message editing protocols, which may feel constraining to some practitioners.

**Learning Curve**: Effective implementation requires understanding AI cognitive patterns and attention management techniques.

### 6.3 Comparison to Existing Methodologies

Unlike traditional methodologies that assume human cognitive limitations, GPA assumes AI analytical abundance and focuses on filtering and focusing rather than generating options.

Unlike pure AI-driven development, GPA maintains human architectural authority while maximizing AI contribution value.

Unlike Agile or iterative approaches, GPA front-loads architectural thinking to prevent costly rework and scope drift.

## 7. Implementation Guidelines

### 7.1 Adopting GPA

**Prerequisites**:
- Access to sophisticated AI coding assistant
- Willingness to articulate philosophical positions
- Commitment to systematic process following
- Discipline for message editing and phase blocking

**Getting Started**:
1. Begin with small projects to develop methodology comfort
2. Practice strategic naming and its impact on AI focus
3. Document decision principles as they emerge
4. Build portfolio of successful GPA applications
5. Master the seven-prompt structure through deliberate practice

### 7.2 Common Pitfalls

**Phase Skipping**: Jumping directly from vision to implementation without stress testing or philosophical grounding.

**Continuation Prompting**: Using multiple prompts instead of editing messages, leading to context drift.

**Premature Progression**: Moving to next phase before achieving satisfaction with current phase.

**Scope Creep Acceptance**: Failing to make principled cuts during boundary setting.

**AI Deference**: Allowing AI analysis to override human architectural judgment.

**Argument Traps**: Trying to make AI "understand better" instead of maintaining consistent vision communication.

## 8. Future Research Directions

### 8.1 Methodology Refinement

Further research should explore:
- Optimal message editing strategies for different AI models
- Phase satisfaction criteria and measurement techniques
- Adaptation of GPA for different project types and team sizes
- Integration with existing software development lifecycle approaches

### 8.2 Tool Development

Supporting tools could include:
- GPA phase tracking and guidance systems
- Message editing interfaces optimized for architectural design
- AI prompting frameworks with built-in phase structure
- Process effectiveness measurement and improvement tools

### 8.3 Cognitive Studies

Research opportunities in understanding:
- AI attention patterns and management strategies
- Human-AI collaborative cognitive load optimization
- Strategic naming impact on AI focus and performance
- Long-term methodology adoption and effectiveness patterns

## 9. Conclusion

Grounded Progressive Architecture represents a systematic approach to human-AI collaborative software development that preserves human architectural authority while maximizing AI analytical contribution. Through its structured phase approach, disciplined communication protocols, and philosophical grounding, GPA addresses the unique challenges of AI-assisted development: information overload, scope drift, vision dilution, and attention fragmentation.

The methodology's effectiveness stems from its recognition that human-AI collaboration requires fundamentally different approaches than purely human development processes. By explicitly leveraging AI strengths while maintaining human decision authority through structured interaction patterns, GPA enables more focused, coherent, and ultimately successful software development projects.

As AI capabilities continue to evolve, methodologies like GPA will become increasingly important for ensuring that enhanced analytical capabilities serve human creative vision rather than overwhelming it. The future of software development lies not in AI replacing human judgment, but in methodologies that optimize human-AI collaboration for better outcomes while respecting the cognitive realities of both human architects and AI systems.

The seven-prompt Sinatra case study demonstrates that complete architectural specification is achievable through disciplined application of GPA principles, providing a reproducible template for future human-AI collaborative design endeavors.

---

**Author Biographies**

**Eliran Sabag** (eliran.sbg@gmail.com) is a software architect with extensive experience in AI-assisted development. This methodology emerged from his practical software development work, with particular focus on maintaining architectural coherence during human-AI collaborative design processes. The Grounded Progressive Architecture methodology was developed through real-world application in building developer tools and AI-integrated systems.

**Gal Moshkovitz** (https://www.linkedin.com/in/gal-moshkovitz/) is a senior AI security researcher focused on AI-assisted development, AI productivity, GenAI red teaming, and AI agent automation. He designs, automates, and hardens agent workflows end to end, including tool orchestration, policy and permissions, evals, and guardrails. He builds practical playbooks and tooling for LLM pentesting, prompt-risk analysis, and agent operations. Gal combines attacker mindset with defender rigor, turning real workflows into repeatable methods. He co-develops Grounded Progressive Architecture for human-AI collaboration and publishes field-tested guides used by engineering and security teams.

**Methodology Development**: The GPA methodology was developed through collaborative analysis between human architectural thinking and AI analytical capabilities, demonstrating the methodology itself in practice. The Sinatra project case study represents a complete application of GPA from initial concept to implementation specification.

---

## Appendix: Reproducible Prompt Sequence for Sinatra Project

For research reproducibility, the exact seven-prompt sequence that generated the complete Sinatra system architecture using Claude Sonnet 4 (claude-sonnet-4-20250514) via the Anthropic API:

**Prompt 1 (Phase 1: Concrete Vision Casting):**
```
I want to design a mcp "memory" server and agent. Once he scan a project (suppose python/JS/Typescript) he will make a networkx graph mapping all the project classes and modules (imported builtin and externals can be ignored unless important). Connecting the nodes with their relationships as edges).

Later when we built a project from md files we will be able to update and query it.

While testing, we can compare implementation to actually state.

This leverage deterministic knowledge with code agents statistics behavior.

Don't code nothing, think about it.
```

**Prompt 2 (Phase 2: Iterative Deepening - Cycle 1):**
```
About queries, I will give you a vision example: compering the trace log of a failure to the graph to figure what is missing.
```

**Prompt 3 (Phase 2: Iterative Deepening - Cycle 2):**
```
Next, another scenario: the agent will create a vision graph (can have a implement flag), there will be a codebase graph (we scanned). And use this diff engine to know what is missing.
```

**Prompt 4 (Phase 3: Collaborative Stress Testing):**
```
Anything else I am missing? not thinking far into the future of deterministic/vibing? pros/cons?
```

**Prompt 5 (Phase 4: Philosophical Grounding):**
```
Version control and branches: we will use a graphs database, allow us to save for later sessions and collaborate teams. Plus efficient diffs. No need to reinvent the wheel. I think separate graphs will be easier to maintain/sync.
Team conflicts - our job is to flood problems, might suggest but not fix and replace the developer. Evolution problem: up to the developer to decide. Cognitive load: this system will reduce them.
Meta Challenge and Philosophy: no single point of truth(except one god), This is my vision, I did it my way...

Dynamic situation you described: off the scope of this project (vision<->codebase<->tracelog), It's complicated enough without them).
```

**Prompt 6 (Phase 5: Principled Boundary Setting and Implementation):**
```
The system name will honor "Sinatra". Break it down to consice vision, prd and implementation md files. No over engendering.
```

**Prompt 7 (Phase 5: Final Documentation):**
```
Now a final document that explains the philosophy and the choices we did.
```

**Prompt 8 (Phase 6: Meta-Cognitive Review):**
```
I want one last meta review document on how my (the user, Eliran) approach of designing to help my friends:
How I introduced you the problem, then we extended it, review it and I responded to your concerns, then to the vision, to the final plans. I might confused the order. Dig into my thinking process.
```

This sequence demonstrates the complete GPA methodology application, from initial concrete vision through iterative deepening, stress testing, philosophical grounding, boundary setting, and meta-cognitive analysis, resulting in a complete architectural specification for a novel AI-assisted development tool.