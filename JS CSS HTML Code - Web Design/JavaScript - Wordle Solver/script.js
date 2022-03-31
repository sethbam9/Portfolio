// Global Variables
const guessesListNode = document.getElementById('guesses');

const grid = [];
const colors = ['#86888a', '#c9b458', '#6aaa64'];
const lettersNotInWord = new Set();

let words = [];
let currentRow = 0;
let targetWord = "";
let startWord = "";

// Universal key listener
document.addEventListener('keyup', (e) =>
	{
		// Only trigger on enter key
		if (e.code == "Enter") {
			button = document.getElementById('enter-button');
			button.click();
		}
	});
document.getElementById('enter-button').addEventListener('click', addNextGuess);
document.getElementById('submit-target-word').addEventListener('click', saveTargetWord);

function saveTargetWord() {
  targetWord = document.getElementById("target-word").value;
}

// Creates 6 rows of boxes for words
function createGrid() {
	for (let i=0; i<6; i++) {
		const row = document.createElement('div');
		row.className = 'row';
    row.classList.add('text');

    gridRow = [];
		for (let i=0; i<5; i++) {
			const mtBox = document.createElement('div');
			mtBox.className = 'mt';
			row.appendChild(mtBox);
      const box = {
        letter: ' ',
        colorIndex: 0,
        boxNode: mtBox
      };
      gridRow.push(box);
		}
    grid.push(gridRow);

    guessesListNode.appendChild(row);
	}
}

// Gives next suggested guess
function addGuess(word) {
  // Check if the new word is the target word
  if (word == targetWord.toUpperCase()) {
    const row = grid[currentRow];
    for (let i=0; i<5; i++) {
      const box = row[i];
      box.letter = word[i];
      box.boxNode.className = 'letter-button';
      box.boxNode.innerText = word[i];
      box.colorIndex = 2;
      box.boxNode.style.backgroundColor = colors[box.colorIndex];
      box.boxNode.style.outlineColor = colors[box.colorIndex];
    }
    party.confetti(document.getElementById("guesses"));
  }
  else {
    const row = grid[currentRow];
    for (let i=0; i<5; i++) {
      const box = row[i];
      box.letter = word[i];
      box.boxNode.className = 'letter-button';
      box.boxNode.innerText = word[i];
      // If second row, color according to previous row
      if (currentRow > 0) {
        const prevRow = grid[currentRow-1];
        prevRow[i].boxNode.removeEventListener('click', () => {
          prevRow[i].colorIndex = (prevRow[i].colorIndex + 1) % colors.length
          prevRow[i].boxNode.style.backgroundColor = colors[prevRow[i].colorIndex];
          prevRow[i].boxNode.style.outlineColor = colors[prevRow[i].colorIndex];
        });
        // If the current box wasn't grey in the previous guess
        if (prevRow[i].colorIndex == 2) {
          box.colorIndex = prevRow[i].colorIndex;
          box.boxNode.style.backgroundColor = colors[box.colorIndex];
          box.boxNode.style.outlineColor = colors[box.colorIndex];        
        } else {
          box.boxNode.addEventListener('click', () => {
            box.colorIndex = (box.colorIndex + 1) % colors.length
            box.boxNode.style.backgroundColor = colors[box.colorIndex];
            box.boxNode.style.outlineColor = colors[box.colorIndex];
          });
        }
      } else {
        box.boxNode.addEventListener('click', () => {
          box.colorIndex = (box.colorIndex + 1) % colors.length
          box.boxNode.style.backgroundColor = colors[box.colorIndex];
          box.boxNode.style.outlineColor = colors[box.colorIndex];
        });
      }
    }
  }
  currentRow++;
}

async function fetchWords(file) {
  let response = await fetch(file);
  let data = await response.text();
  return data.split('\n');
}

// Checks dictionary for words that meet criteria
function isValidWord(word) {
  const row = grid[currentRow-1];

  function checkInWord(i, l) {
    for (let j=0; j<row.length; ++j) {
      if (i == j) {
        // skip comparing cell with itself
        continue;
      }
      if (l == row[j].letter && row[j].colorIndex != 0) {
        return true;
      }
    }
    return false;
  }

  // iterate through all letters of this row
  for (let i=0; i<row.length; ++i) {
    const cell = row[i];
    const letter = cell.letter;
    for (l of word) {
      if (lettersNotInWord.has(l)) {
        return false;
      }
    }
    // grey (0) = this letter is not in the word
    if (cell.colorIndex == 0) {
      if (word[i] == letter) {
        return false;
      }
      if (!checkInWord(i, letter)) {
        lettersNotInWord.add(letter)
        if (word.includes(letter) || word[i] == letter) {
          return false;
        }
      }
    }
    // yellow (1) = this letter is in the word but not in this position
    else if (cell.colorIndex == 1) {
      if (!word.includes(letter)) {
        return false;
      }
      for (let j=0; j<word.length; ++j) {
        if (word[j] == letter && j == i) {
          return false;
        }
      }
    }
    // green (2) = this letter is in the word at this position
    else {
      if (cell.colorIndex == 2 && word[i] != letter) {
        return false;
      }
    }
  }
  return true;
}

function addNextGuess() {
  for (const word of words) {
    // Our first version of the algorithm will add the first word that fits the criteria
    uppercaseWord = word.toUpperCase();
    if (isValidWord(uppercaseWord)) {
      addGuess(uppercaseWord);
      break;
    }
  }
}

function mainFunction() {
  createGrid();
  fetchWords('words.txt').then(downloadedWords => {
    words = downloadedWords;
  }).then(() => {
    startWord = words[Math.floor(Math.random()*words.length)];
  }).then(() => {
    addGuess(startWord.toUpperCase());
  });
}

mainFunction();
