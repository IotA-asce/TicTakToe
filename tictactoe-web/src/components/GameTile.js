import React from 'react'

const GameTile = ({
    board,
    index,
    setBoard,
    turn,
    setTurn,
    gameOverConfig
}) => {

    const options = [' ', 'X', 'O'];

    const handleClick = () => {
        /**
         * 
         * IF TILE IS ALREADY CLICKED THEN NO CLICK IS REGISTERED
         * 
         * IF GAME IS OVER NO CLICK IS REGISTERED
         * 
         */
        if(board[index] !== 0 || gameOverConfig[0] === 1){
            return;
        }

        setTurn(turn === 1 ? 2 : 1);
        setBoard(board.map((value, id) => id === index ? turn : value));
        console.log(board);
    }

    return (
        <div className='game-tile' onClick={handleClick} >
            <p>
                {
                    options[board[index]]
                }
            </p>
        </div>
    )
}

export default GameTile