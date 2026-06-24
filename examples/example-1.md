# Example 1: Date Picker and CSV Processing

## Date Picker

### AI Slop Solution

The agent installs a date picker library, a date utility package, a theme adapter, and creates:

- `components/DatePicker.tsx`
- `components/CalendarPopover.tsx`
- `hooks/useDatePicker.ts`
- `utils/dateFormat.ts`
- `types/date.ts`

All for a form field where the user picks one date.

```tsx
<ComplexDatePicker
  value={selectedDate}
  onChange={setSelectedDate}
  locale="en-US"
  theme="brand"
  enableRange={false}
/>
```

Problems:

- Extra dependency surface
- More code than product value
- Styling and accessibility now belong to the app
- Future upgrades are another chore

### SanCode Solution

Use the platform.

```html
<label>
  Launch date
  <input name="launchDate" type="date" required>
</label>
```

If the app already uses React:

```tsx
export function LaunchDateField() {
  return (
    <label>
      Launch date
      <input name="launchDate" type="date" required />
    </label>
  );
}
```

SanScore: 96/100

## CSV Processing

### AI Slop Solution

The agent adds a CSV package, stream processor, validation schema, worker queue, and import status table before the founder has imported one customer file.

```text
csv-engine/
import-service/
validation-pipeline/
background-worker/
import-events/
```

Problems:

- Assumes scale before usage
- Turns an admin task into infrastructure
- Adds failure modes customers never asked for

### SanCode Solution

For small internal imports, parse the uploaded text directly and handle the known columns.

```js
function parseSimpleCsv(text) {
  const [headerLine, ...rows] = text.trim().split("\n");
  const headers = headerLine.split(",").map((value) => value.trim());

  return rows.map((row) => {
    const values = row.split(",").map((value) => value.trim());
    return Object.fromEntries(headers.map((header, index) => [header, values[index] || ""]));
  });
}
```

Use a real CSV parser only when customers upload messy CSVs with quotes, escaped commas, large files, or repeated import failures.

SanScore: 88/100

