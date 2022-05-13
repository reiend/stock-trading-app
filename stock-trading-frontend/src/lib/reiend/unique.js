"use strict";

import { randomNumber } from "./helpers"; 

// uniue id generator
const UniqueID = () => {

  const uniqueIDs = {};

  return (uniqueIDLength) => {
    const countingNumbers = [
      "0", "1", "2", "3", "4",
      "5", "6", "7", "8", "9",
    ];
    const alphabet = [
      "a", "b", "c", "d", "e",
      "f", "g", "h", "i", "j",
      "k", "l", "m", "n", "o",
      "p", "q", "r", "s", "t",
      "u", "v", "w", "w", "x",
      "y", "z",
    ];

    let uniqueID = "";
    let lettersID = "";
    let numbersID = "";

    const ALPHABET_LENGTH = alphabet.length;
    const COUNTING_NUMBERS_LENGTH = countingNumbers.length;

    const generateRandomLettersID = (uniqueIDLength) => {
      const getRandomAlphabetNumber = () => randomNumber(ALPHABET_LENGTH)

      for (let i = 0; i <= uniqueIDLength; i++) {
        const randomAlphabetNumber = getRandomAlphabetNumber();
        if (randomAlphabetNumber & 1) {
          lettersID += alphabet[randomAlphabetNumber].toUpperCase();
        } else {
          lettersID += alphabet[randomAlphabetNumber].toLowerCase();
        }
      }
    };

    const generateRandomNumbersID = (uniqueIDLength) => {
      const getRandomCountingNumber = () => randomNumber(COUNTING_NUMBERS_LENGTH);

      for (let i = 0; i <= uniqueIDLength; i++) {
        const randomCountingNumber = getRandomCountingNumber();
        if (randomCountingNumber & 1) {
          numbersID += countingNumbers[randomCountingNumber].toUpperCase();
        } else {
          numbersID += countingNumbers[randomCountingNumber].toLowerCase();
        }
      }
    };

    const init = (uniqueIDLength) => {

      const { letters, numbers } = uniqueIDLength;

      generateRandomLettersID(letters);
      generateRandomNumbersID(numbers);

      uniqueID = lettersID + numbersID;
    };

    init(uniqueIDLength);

    if(!uniqueIDs[uniqueID]) {
      uniqueIDs[uniqueID] = uniqueID;
      return uniqueID
    }  

    return uniqueID;
  };
};

export default UniqueID();
