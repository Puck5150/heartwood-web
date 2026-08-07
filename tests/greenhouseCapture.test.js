import { describe, it, expect } from 'vitest';
import { prepareCapture } from '../src/lib/greenhouseCapture.js';

describe('prepareCapture', () => {
  it('trims surrounding whitespace', () => {
    expect(prepareCapture('  call mom back  ')).toBe('call mom back');
  });

  it('returns null for empty or whitespace-only input', () => {
    expect(prepareCapture('   ')).toBeNull();
    expect(prepareCapture('')).toBeNull();
  });

  it('truncates to 140 characters, keeping the prefix', () => {
    const long = 'a'.repeat(140) + 'b'.repeat(60);
    const result = prepareCapture(long);
    expect(result).toBe('a'.repeat(140));
  });
});
