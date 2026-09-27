# Walker — MIDI Piano

**What this is.** An independent local copy of the Godot demo `audio/midi_piano` at commit a3b5c113112f77291d5f3d1360f33a882fdc52f7, kept in Walker as a tech demo, not a game: an 88-key on-screen piano that plays one A440 sample, pitch-shifted per key, from mouse clicks or MIDI note messages. Production edits: application title and MIDI filtering (ignore non-note messages; velocity-zero note-on releases instead of retriggering).

**Why it is in Walker.** It is the source for two planned native-4K Liam films about MIDI input in Godot. Both films and human review remain pending under the existing capture constraint.

**What was found and verified.** Godot 4.7.2 headless/Dummy import and startup are clean. `test_piano.gd` checks 88 keys, 52 white keys, A220/440/880 pitch ratios, actual mouse activation of white and black keys, color timeout and natural audio-node cleanup. Seven synthetic MIDI parser checks pass after reproducing and fixing three failures; a later boundary run at pitches 21 and 108 passes 13/13; mouse regression remains 12/12. These are state tests, not heard sound, MIDI hardware verification or rendered footage. No MIDI inputs were reported locally, and no visible window was opened. See FRICTIONAL.md.

## How to run

Open `godot/project.godot` in Godot 4.7 and run the main scene (`piano.tscn`).

Controls:

- **Mouse**: click a key to play it. The key highlights briefly; the note plays for up to 8 seconds.
- **MIDI keyboard** (if connected): note-on plays the key; note-off or a zero-velocity note-on restores its colour. Releasing a key does not stop the sound.

The project defines no custom input actions.

## Design

- [GDD.md](GDD.md): recovered game design document, every claim tagged `[OBSERVED]`, `[INFERRED]` or `[MISSING]`. It is a recovered, unapproved description, not an approved design; no design gate is signed.
- [design/DECK.html](design/DECK.html): slide deck of the recovered GDD.
- [design/IMPLEMENTATION-MAP.md](design/IMPLEMENTATION-MAP.md): features mapped to scene, script and line.
- [design/decisions.md](design/decisions.md): open questions, starting with whether films show upstream or locally fixed MIDI behavior.

## Source & license

Root MIT LICENSE.md (Godot Engine contributors), original README, assets and UIDs retained. ASSET-PROVENANCE.md records the WAV's SHA256, file properties and source introduction commit; it establishes file properties only, not recording authorship, pitch or an independent rights audit. No separate WAV-specific attribution or license was found in the demo files inspected.

## Status

- Mouse and synthetic MIDI state checks pass; no physical MIDI test or audible result is implied.
- Inherited behavior to describe honestly: the source sample is 8.010884 s, but each voice is freed at 8 s regardless of pitch, so lower-pitched notes may be truncated.
- Both native-4K Liam films and human review are pending.
- Repository: https://github.com/nikbearbrown/walker-audio-midi-piano
