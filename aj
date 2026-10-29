<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Awesome Arcade - Bros & Retro Bowl Hub</title>
    <style>
        :root {
            --bg-dark: #0f111a;
            --sidebar-bg: #171a26;
            --card-bg: #1f2336;
            --accent-orange: #ff6b00;
            --accent-blue: #00a2ff;
            --text-main: #ffffff;
            --text-muted: #8b92b5;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            user-select: none;
        }

        body {
            background-color: var(--bg-dark);
            color: var(--text-main);
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        /* Sidebar Navigation */
        .sidebar {
            width: 240px;
            background-color: var(--sidebar-bg);
            display: flex;
            flex-direction: column;
            border-right: 2px solid #282d42;
            padding: 20px;
        }

        .logo {
            font-size: 22px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 30px;
            color: var(--accent-orange);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .menu-btn {
            background: none;
            border: none;
            color: var(--text-muted);
            text-align: left;
            padding: 12px 15px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            border-radius: 8px;
            margin-bottom: 8px;
            transition: all 0.2s ease;
        }

        .menu-btn.active, .menu-btn:hover {
            background-color: var(--card-bg);
            color: var(--text-main);
        }

        .menu-btn.active {
            border-left: 4px solid var(--accent-orange);
        }

        /* Main Game Arena Dashboard */
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .navbar {
            height: 60px;
            background-color: var(--sidebar-bg);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            border-bottom: 2px solid #282d42;
        }

        .player-tag {
            background: #282d42;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
            color: var(--accent-blue);
            border: 1px solid #3d4563;
        }

        /* Interactive Grid Layout */
        .grid-container {
            flex: 1;
            padding: 30px;
            overflow-y: auto;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 25px;
            align-content: start;
        }

        .game-card {
            background-color: var(--card-bg);
            border-radius: 12px;
            overflow: hidden;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            border: 2px solid transparent;
            display: flex;
            flex-direction: column;
        }

        .game-card:hover {
            transform: translateY(-5px);
            border-color: var(--accent-orange);
            box-shadow: 0 8px 20px rgba(255, 107, 0, 0.2);
        }

        .game-thumbnail {
            width: 100%;
            height: 150px;
            background: linear-gradient(135deg, #2b304a, #171a26);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        .game-thumbnail::before {
            content: "🎮";
            font-size: 40px;
        }

        /* Specialized Custom Art Accents for specific games */
        .card-basket .game-thumbnail { background: linear-gradient(135deg, #ff9900, #ff5500); }
        .card-basket .game-thumbnail::before { content: "🏀"; }

        .card-soccer .game-thumbnail { background: linear-gradient(135deg, #2ecc71, #27ae60); }
        .card-soccer .game-thumbnail::before { content: "⚽"; }

        .card-football .game-thumbnail { background: linear-gradient(135deg, #d35400, #962d00); }
        .card-football .game-thumbnail::before { content: "🏈"; }

        .card-retro .game-thumbnail { background: linear-gradient(135deg, #9b59b6, #8e44ad); }
        .card-retro .game-thumbnail::before { content: "🏟️"; }

        .game-title {
            padding: 12px;
            font-weight: 700;
            font-size: 15px;
            text-align: center;
            background-color: rgba(0,0,0,0.2);
        }

        /* Fullscreen Game Screen Cover */
        .game-screen {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background-color: #05070f;
            z-index: 100;
            flex-direction: column;
        }

        .game-header {
            height: 50px;
            background-color: var(--sidebar-bg);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px;
            border-bottom: 2px solid #282d42;
        }

        .back-btn {
            background-color: #282d42;
            border: none;
            color: white;
            padding: 6px 14px;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
        }

        .back-btn:hover {
            background-color: #ff3333;
        }

        /* Simulation Canvas Setup */
        .game-canvas-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            background: radial-gradient(circle, #1a1e29 0%, #05070f 100%);
            position: relative;
        }

        canvas {
            background-color: #111;
            box-shadow: 0 10px 30px rgba(0,0,0,0.7);
            border: 4px solid #282d42;
            border-radius: 4px;
        }

        .controls-overlay {
            position: absolute;
            bottom: 20px;
            background: rgba(0,0,0,0.7);
            padding: 10px 20px;
            border-radius: 20px;
            font-size: 13px;
            color: var(--text-muted);
            pointer-events: none;
        }
    </style>
</head>
<body>

    <!-- Sidebar Layout Navigation -->
    <div class="sidebar">
        <div class="logo">⚡ BROS BOWL</div>
        <button class="menu-btn active">All Games</button>
        <button class="menu-btn">Bros Originals</button>
        <button class="menu-btn">Retro Bowls</button>
        <button class="menu-btn">Settings</button>
    </div>

    <!-- Main Launcher Framework -->
    <div class="main-content">
        <div class="navbar">
            <div style="font-weight: bold; font-size: 18px;">Select a Title to Play Instantly</div>
            <div class="player-tag">BALLER9014</div>
        </div>

        <div class="grid-container" id="gamesGrid">
            <!-- Programmatically Generated Launcher Items populate here -->
        </div>
    </div>

    <!-- Screen Cover Mode for Active Gameplay -->
    <div class="game-screen" id="gameScreen">
        <div class="game-header">
            <span id="currentGameTitle" style="font-weight: bold; font-size: 18px;">Game</span>
            <button class="back-btn" onclick="closeGame()">✕ Close Game</button>
        </div>
        <div class="game-canvas-container">
            <canvas id="arcadeCanvas" width="800" height="450"></canvas>
            <div class="controls-overlay">Controls: Use Arrow Keys or WASD to move & jump / Space to act</div>
        </div>
    </div>

    <script>
        // Game Titles definitions targeting your requested roster
        const gamesData = [
            { id: 'basketbros', title: 'Basket Bros', type: 'basket' },
            { id: 'soccerbros', title: 'Soccer Bros', type: 'soccer' },
            { id: 'footballbros', title: 'Football Bros', type: 'football' },
            { id: 'retrobowl', title: 'Retro Bowl Classic', type: 'retro' },
            { id: 'retrobowl26', title: 'Retro Bowl 2026', type: 'retro' },
            { id: 'retrobowlcollege', title: 'Retro Bowl College', type: 'retro' }
        ];

        const grid = document.getElementById('gamesGrid');
        const screen = document.getElementById('gameScreen');
        const canvas = document.getElementById('arcadeCanvas');
        const ctx = canvas.getContext('2d');
        const titleHeader = document.getElementById('currentGameTitle');

        let animationFrameId = null;
        let gameState = {};

        // Generate dynamic interactive catalog cards
        gamesData.forEach(game => {
            const card = document.createElement('div');
            card.className = `game-card card-${game.type}`;
            card.innerHTML = `
                <div class="game-thumbnail"></div>
                <div class="game-title">${game.title}</div>
            `;
            card.onclick = () => launchGame(game);
            grid.appendChild(card);
        });

        // Initialize internal engine mechanics based on the selection
        function launchGame(game) {
            screen.style.display = 'flex';
            titleHeader.innerText = game.title;
            
            // Set up local structural variables for basic gameplay rendering simulation
            gameState = {
                type: game.type,
                playerX: 150,
                playerY: 350,
                ballX: 400,
                ballY: 200,
                ballDX: 3,
