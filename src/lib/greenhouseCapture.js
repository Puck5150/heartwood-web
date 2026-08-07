export function prepareCapture(raw) {
  const trimmed = raw.trim();
  if (!trimmed) return null;
  return trimmed.length > 140 ? trimmed.slice(0, 140) : trimmed;
}
