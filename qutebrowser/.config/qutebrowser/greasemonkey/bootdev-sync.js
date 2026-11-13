// ==UserScript==
// @name         boot.dev nvim sync
// @namespace    bootdev
// @match        https://*.boot.dev/lessons/*
// @match        https://boot.dev/lessons/*
// @match        https://*.boot.dev/code-submission/*
// @match        https://boot.dev/code-submission/*
// @grant        none
// @qute-js-world main
// @run-at       document-idle
// ==/UserScript==

// Receives code pushed by ~/bin/bootdev-sync over SSE. window.bootdevPull()
// sends the current editor contents to the daemon, which writes the lesson
// file and opens it in nvim.

(function () {
  const SERVER = "http://127.0.0.1:8765";

  let source = null;
  let lastUuid = null;

  const lessonUuid = () => {
    const match = location.pathname.match(
      /^\/(?:lessons|code-submission)\/([0-9a-f-]+)/,
    );
    return match ? match[1] : null;
  };

  // boot.dev attaches the CodeMirror EditorView to the .cm-content element as
  // `cmTile.view` (a property, not a class). Prefer the visible editor.
  const editorView = () => {
    const editors = Array.from(document.querySelectorAll(".cm-content"));
    const visible = editors.find(
      (el) => el.cmTile?.view && el.offsetParent !== null,
    );
    return (visible || editors.find((el) => el.cmTile?.view))?.cmTile?.view || null;
  };

  function apply(code) {
    if (typeof code !== "string") return;
    const view = editorView();
    if (!view) return;
    if (view.state.doc.toString() === code) return;
    view.dispatch({
      changes: { from: 0, to: view.state.doc.length, insert: code },
    });
  }

  function connect() {
    const uuid = lessonUuid();
    if (!uuid) return;
    lastUuid = uuid;

    if (source) source.close();
    source = new EventSource(`${SERVER}/events?uuid=${encodeURIComponent(uuid)}`);
    source.onmessage = (event) => {
      try {
        apply(JSON.parse(event.data).code);
      } catch (_) {
        // Ignore malformed events.
      }
    };
    // EventSource reconnects on its own.
  }

  // qutebrowser's Greasemonkey wrapper shadows `window`; expose the function
  // on the real page window so `:jseval --quiet --world main bootdevPull()`
  // can call it.
  const pageWindow = typeof unsafeWindow !== "undefined" ? unsafeWindow : window;
  pageWindow.bootdevPull = async () => {
    const view = editorView();
    if (!view) return;
    const uuid = lessonUuid();
    if (!uuid) return;
    try {
      await fetch(`${SERVER}/pull?uuid=${encodeURIComponent(uuid)}`, {
        method: "POST",
        body: view.state.doc.toString(),
      });
    } catch (_) {
      // Daemon is down; nothing to do.
    }
  };

  connect();

  // boot.dev may navigate between lessons without a full reload.
  setInterval(() => {
    const uuid = lessonUuid();
    if (uuid && uuid !== lastUuid) connect();
  }, 1000);
})();
