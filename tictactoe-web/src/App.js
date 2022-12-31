import { useEffect, useState } from 'react';
import './App.css';
import GameTile from './components/GameTile';
import { isGameOver } from './engine/engine';


function App() {
  const [board, setBoard] = useState(
    [
      0, 0, 0,
      0, 0, 0,
      0, 0, 0
    ]
  );

  const [turn, setTurn] = useState(1);

  const handleResetButton = () => {
    setTurn(1);
    setGameOverConfig([0,0,0,0]);
    setBoard(
      [
        0, 0, 0,
        0, 0, 0,
        0, 0, 0
      ]
    );
  }

  /**
   * 1 -> horizontal
   * 2 -> vertical
   * 3 -> skewed forward
   * 4 -> skewed backward
   */
  const [gameOverLineOrientation, setGameOverLineOrientation] = useState(0);

  /**
   * [0 - 2]  horizontal / vertical
   */
  const [offset, setOffset] = useState(-1);
  const [gameOverConfig, setGameOverConfig] = useState([0,0,0,0]);
  
  useEffect(() => {
    setOffset(-1);
    setGameOverLineOrientation(0);
  }, []);

  useEffect(() => {
    console.log(isGameOver(board), board);
    setGameOverConfig(isGameOver(board));

  }, [board, gameOverLineOrientation, offset])

  return (
    <div className="App">
      <div>{gameOverConfig[0] === 1 && "gameover"}</div>
      <div className='game-board'>
        {
          gameOverConfig[0] === 1 &&
          <div
            className='game-over-line'
            style={{
              top: `${gameOverConfig[1]}%`,
              left: `-0.5em`,
              rotate: `${gameOverConfig[3]}deg`,
              translate: `${gameOverConfig[2]}em ${gameOverConfig[4]}em`
            }}
          >
          </div>
        }
        {
          board.map(
            (value, index) => {
              return (
                <GameTile
                  key={index}
                  tileValue={value}
                  board={board}
                  index={index}
                  setBoard={setBoard}
                  turn={turn}
                  setTurn={setTurn}
                  gameOverConfig={gameOverConfig}
                />
              )
            }
          )
        }
      </div>
      <div>
        <button className='reset-button' onClick={handleResetButton}>
          Reset
        </button>
      </div>
    </div>
  );
}

export default App;
