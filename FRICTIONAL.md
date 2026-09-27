# Evidence — 2026-09-27 14:06 UTC

## 15:06 UTC continuation

- Extended synthetic parser checks to range endpoints21/108: activation,
  ignored controller messages and note-off highlight reset. midi-boundaries log
  passes13/13, exit0 clean. No physical MIDI or heard audio claim.
- Recorded WAV SHA256, ffprobe properties and source introduction commit in
  ASSET-PROVENANCE.md. Initial git probe ran from the non-repository sibling and
  failed; corrected read-only query against original checkout succeeded.
- Source sample is8.010884s, but upstream voice lifetime remains8s regardless
  of pitch. Lower-pitched playback may truncate; no listening or duration-fix
  claim made. That inherited behavior must be described honestly in films.
- Capture/listening/hardware remain externally unavailable under the known
  constraints. Both films remain pending, not retired. Next feasible item65 may
  proceed; revisit physical MIDI, audio quality and capture when available.

## 14:36 UTC: MIDI parser corrections

- test_midi.gd feeds constructed InputEventMIDI through Input.parse_input_event.
  This is explicitly synthetic parser testing, not physical MIDI capture.
- Initial midi-before log contains a harness parse error (wrong constant name),
  despite engine exit0. Corrected to numeric0xA for polyphonic key pressure;
  midi-baseline log then reproduced3/7 failures: pressure cleared highlight,
  velocity-zero note-on highlighted and created another voice.
- Local piano.gd now ignores non-note messages and treats zero-velocity note-on
  like note-off. midi-after log passes7/7, exit0 clean, including out-of-range
  pitches and natural voice cleanup. mouse-regression log passes12/12 clean.
- Deactivation still only restores color, as upstream: no claim of note-off
  muting, sustain support, velocity-sensitive loudness or multi-channel ownership.
  Original logs/source/assets retained. WAV provenance/listening and both films
  pending; existing capture/hardware constraints unchanged.

- Read README, configuration, all three scripts and all three scenes. No source
  AGENTS.md found. New independent sibling copy; source checkout untouched.
- import-20260927.log and runtime-20260927.log: clean Godot4.7.2 headless/Dummy
  import and bounded120-frame startup. No audio device output claimed.
- mouse-input-20260927.log:12/12 checks pass, exit0 clean. Real scene GUI mouse
  events activate notes69/70; pitch ratios,88 keys/52 white keys, color timeout
  and8-second node lifetime checked. No direct activate/deactivate callbacks.
- OS.get_connected_midi_inputs returned[]. Scene opens MIDI inputs as upstream
  does; test closes them after completion. No hardware messages generated.
- MIDI handler currently treats all non-note-on messages as deactivate and
  does not distinguish velocity-zero note-on. These are source observations,
  not yet reproduced/fixed. Next test synthetic MIDI events, clearly labeled
  as parser tests rather than hardware or film evidence.
- WAV-specific provenance and actual listening remain pending. Root license and
  original WAV preserved. Capture constraint unchanged, both films pending.
