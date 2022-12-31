/*
variables
top 45%
transform
    - rotate 
        - [horizontal]  0 deg
        - [vertical]    90 deg
        - [diagonal]    45deg, -45deg
    - translate
        - [Y]       -6em, +6em
*/

export const isGameOver = (board) => {

    /**
     * expand engine to return an array for the offset of the css from a given list of predefinec settings
     * [isGameOver, top, left, transform[rotate - deg], translate[Y]];
     * 
     */

    // horizontal check
    if (rowCheck(board, 0)) return [1, 45, 0, 0, -6];
    if (rowCheck(board, 3)) return [1, 45, 0, 0, 0];
    if (rowCheck(board, 6)) return [1, 45, 0, 0, 6];

    if (colCheck(board, 0)) return [1, 45, -6, 90, 0];
    if (colCheck(board, 1)) return [1, 45, 0, 90, 0];
    if (colCheck(board, 2)) return [1, 45, 6, 90, 0];

    // left: -0.5em;
    // top: 45%;
    // transform: rotate(45deg) translateY(0em);
    if (diagonalCheckBackward(board)) return [1, 45, 0, 45, 0];
    if (diagonalCheckForward(board)) return [1, 45, 0, -45, 0];

    return [0, 0, 0, 0];
}

const rowCheck = (board, startIndex) => {
    let count = 0;
    let check = board[startIndex];
    if (check === 0) {
        return false;
    }
    for (let itt = startIndex; itt < startIndex + 3; itt++) {
        if (check === board[itt]) {
            count++;
        }
    }

    return count === 3;
}

const colCheck = (board, startIndex) => {
    let count = 0;
    let check = board[startIndex];
    if (check === 0) {
        return false;
    }
    for (let i = startIndex; i <= startIndex + 6; i += 3) {
        if (check === board[i]) {
            count++;
        }
    }

    return count === 3;
}

const diagonalCheckForward = (board) => {
    let check = board[2];
    if (check === 0) {
        return false;
    }

    if (board[2] === board[4] && board[4] === board[6]) {
        return true;
    }
}

const diagonalCheckBackward = (board) => {
    let check = board[0];
    if (check === 0) {
        return false;
    }

    if (board[0] === board[4] && board[4] === board[8]) {
        return true;
    }
}