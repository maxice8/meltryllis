// ==UserScript==
// @name        ChessComFEN
// @namespace   ChessComFEN
// @match       *://www.chess.com/*
// @grant       GM_setClipboard
// @version     0.1
// @require     https://cdn.jsdelivr.net/npm/chess.js@0.10.3
// @author      leo
// @description 25/10/2020, 15:50:05
// ==/UserScript==
let host = window.location.host;
let path = window.location.pathname;
let movelength = 0;

// Copied from https://greasyfork.org/en/scripts/32323-auto-copy/code
if (typeof GM_setClipboard != 'function') alert('Your UserScript client has no GM_setClipboard support');

// Copied from https://greasyfork.org/en/scripts/32323-auto-copy/code
/*
 *  GMC.setClipboard(text)
 *
 *  Sets content of the clipboard by using either GM.setClipboard or GM_setClipboard.
 *  Grants:
 *  GM.setClipboard
 *  GM_setClipboard
 */
let setClipboard = (typeof GM_setClipboard === 'function' ? GM_setClipboard : (typeof GM === 'object' && GM !== null && typeof GM.setClipboard === 'function' ? GM.setClipboard : null) );

// Copied from ChessBotPy
if (host === 'www.chess.com') {
	window.document.domain = 'chess.com';
}

// Copied from ChessBotPy
const cleanse = (x) => {
	chars = ['↵', '✓', '1-0', '0-1', '1/2-1/2', '\n', /\[+-][0-9.]+/];
	for (let c of chars) {
		x = x.replace(c, '');
	}
	return x.trim();
};

// Copied from ChessBotPy
let siteMap = {
  'www.chess.com': {
		movesSelector: '.vertical-move-list, .horizontal-move-list-component, .computer-move-list, .move-list-controls-component, .move-list-component',
		sanSelector: '.move-text-component, .gotomove, .move-list-controls-move, .move-component, .move-text, .white, .black',
		overlaySelector: '#chessboard_boardarea, .board-layout-chessboard, .board-board',
		analysisSelector: '.with-analysis, .with-analysis-collapsed',
		sideFinder: () => (document.querySelector('.board-player-default-bottom.board-player-default-black') != null ? BLACK : WHITE)
	}
};

// Copied and Adapted from ChessBotPy
function hotkey(e) {
  // The user must press both ctrl and shift
  if (!e.ctrlKey || !e.shiftKey) {
    return;
  }
  switch (e.code) {
    case 'KeyF':
      console.log("Getting FEN because Ctrl+Shift+F was pressed");
      getFEN(true);
      break;
    default:
      break;
  }
};

const buildPGN = async moves => {
  let PGN = "1.";
  let movecount = 2;
  
  const movelength = moves.length;
  for (let i = 0; i < movelength; i += 2) {
    PGN = PGN + " " + moves[i]
    if (i + 1 < movelength) {
      PGN = PGN + " " + moves[i + 1];
    }
    if (i + 2 < movelength) {
      PGN = PGN + " " + movecount + ".";
      movecount++;
    }
  }
  return PGN
};

const getFEN = async force => {
  // Create a new board, always.
  let board = new Chess();
  
  // Wait for the element to appear, we will use it to extract the moves
  let element = await waitForElement(siteMap[host].sanSelector, 1);
  if (element == null) {
    return;
  }
  let moves = [...document.querySelectorAll(siteMap[host].sanSelector)].map((x) => cleanse(x.innerText)).filter((x) => x != '');
  
  if (window.location.pathname != path) {
    path = window.location.pathname
    movelength = 0;
  }
  
  if (moves.length == 0) {
    setClipboard('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
    return;
  }
  
  // Check if we are on the same path as before and we have the same number of moves, abort if we do.
  if (moves.length === movelength && !force) {
    console.log("Leaving, we already looked here");
    return;
  } else {
    path = window.location.pathname;
    movelength = moves.length;
  }
  const PGN = await buildPGN(moves);
  console.log(PGN)
  board.load_pgn(PGN);
  setClipboard(board.fen());
};

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

const waitForElement = async (selector, timeout) => {
	let now = Date.now();
	const end = now + timeout * 1000;
	while (end > now) {
		now = Date.now();
		let element = document.querySelector(selector);
		if (element != null) {
			console.log('Found element.');
			return element;
		}
		await sleep(100);
	}
	console.warn('Waiting for element timed out');
	return null;
};

const main = async () => {
  document.addEventListener('keydown', hotkey);
  
  var target = await waitForElement(siteMap[host].movesSelector, 60);
  
  let timer
  // create an observer instance
  var observer = new MutationObserver(function(mutations) {
    if (timer) clearTimeout(timer);
    timer = setTimeout(() => {
      mutations.forEach(function(mutation) {
        if (mutation.addedNodes.length) {
          console.log("Getting FEN because", mutation.addedNodes.length, "nodes were added");
          getFEN(false);
        }
      });
    }, 500);
  });

  // configuration of the observer:
  var config = { attributes: false, childList: true, characterData: false, subtree: true };
 
  // pass in the target node, as well as the observer options
  observer.observe(target, config);
};

main();