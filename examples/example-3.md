# Example 3: Dashboard

## Dashboard

### AI Slop Solution

The agent builds a full analytics system:

- Charting package
- Metrics service
- Events table
- Aggregation worker
- Date range picker
- Export system
- Role-based widgets
- Drag-and-drop layout
- Dashboard preferences

The founder asked: "Can I see signups and revenue?"

Problems:

- Confuses investor-demo polish with product value
- Adds state, dependencies, and maintenance
- Makes the team debate charts instead of customers

### SanCode Solution

Show the few numbers that change decisions.

```tsx
export function Dashboard({ signups, revenue, churnedAccounts }) {
  return (
    <main>
      <h1>Dashboard</h1>

      <dl>
        <div>
          <dt>Signups</dt>
          <dd>{signups}</dd>
        </div>
        <div>
          <dt>Revenue</dt>
          <dd>${revenue}</dd>
        </div>
        <div>
          <dt>Churned accounts</dt>
          <dd>{churnedAccounts}</dd>
        </div>
      </dl>
    </main>
  );
}
```

Add charts when the founder is repeatedly making decisions from trends, not because dashboards are expected.

SanScore: 93/100

## Dashboard Workflow

### AI Slop Solution

The agent proposes a metrics platform before defining the decision.

```text
track everything -> store everything -> chart everything -> decide later
```

### SanCode Solution

Start with the decision.

```text
decision -> metric -> source -> display
```

Examples:

- "Should we keep this acquisition channel?" needs signups by source.
- "Are customers paying?" needs revenue collected this week.
- "Are users activated?" needs one activation event.

If a metric does not change a decision, it does not belong on the first dashboard.

SanScore: 95/100

