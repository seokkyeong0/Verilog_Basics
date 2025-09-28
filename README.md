<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>Verilog Basic Modules — Index</title>
<style>
:root{
--bg:#0f1724; --card:#0b1220; --muted:#94a3b8; --accent:#7c3aed; --glass: rgba(255,255,255,0.03);
--radius:12px; --gap:14px; color-scheme: dark;
font-family: Inter, ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
}
*{box-sizing:border-box}
body{margin:0;background:linear-gradient(180deg,#071027 0%, #071423 60%);color:#e6eef8;min-height:100vh;padding:36px;}
.wrap{max-width:1100px;margin:0 auto}


header{display:flex;gap:16px;align-items:center;justify-content:space-between;margin-bottom:24px}
.title{display:flex;gap:12px;align-items:center}
.logo{width:56px;height:56px;border-radius:10px;background:linear-gradient(135deg,var(--accent),#3b82f6);display:grid;place-items:center;font-weight:700;font-size:18px;box-shadow:0 6px 24px rgba(124,58,237,0.18)}
h1{margin:0;font-size:20px}
p.lead{margin:0;color:var(--muted);font-size:13px}


.controls{display:flex;gap:10px;align-items:center}
.search{background:var(--card);border:1px solid rgba(255,255,255,0.04);padding:8px 12px;border-radius:10px;min-width:240px;color:inherit}
.btn{background:var(--glass);border:1px solid rgba(255,255,255,0.03);padding:8px 10px;border-radius:10px;cursor:pointer}


.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:var(--gap);}
.card{background:linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01));border-radius:var(--radius);padding:16px;border:1px solid rgba(255,255,255,0.03);box-shadow:0 6px 18px rgba(2,6,23,0.6);display:flex;gap:12px;align-items:flex-start;transition:transform .15s ease, box-shadow .15s ease}
.card:hover{transform:translateY(-6px);box-shadow:0 14px 40px rgba(2,6,23,0.7)}
.badge{min-width:44px;height:44px;border-radius:10px;background:rgba(255,255,255,0.03);display:grid;place-items:center;font-weight:700}
.name{font-size:15px;margin:0 0 6px 0}
.meta{color:var(--muted);font-size:13px;margin:0}


footer{margin-top:20px;color:var(--muted);font-size:13px}


/* responsive tweaks */
@media (max-width:520px){
.search{min-width:140px}
header{flex-direction:column;align-items:flex-start;gap:12px}
}
</style>
</head>
<body>
<div class="wrap">
<header>
<div class="title">
<div class="logo">V</div>
<div>
<h1>Verilog Basic Modules</h1>
<p class="lead">Clean, searchable index of common Verilog building blocks.</p>
</div>
</div>


<div class="controls" role="region" aria-label="controls">
<input id="search" class="search" type="search" placeholder="Search module name or number (eg. 'adder' or '4')" aria-label="Search modules"/>
<button id="reset" class="btn" title="Reset search">Reset</button>
<button id="copyList" class="btn" title="Copy list as plain text">Copy</button>
</div>
</header>


<main>
<section id="grid" class="grid" aria-live="polite">
<!-- Cards injected by JavaScript -->
</section>
</main>


<footer>Tip: type part of a name (e.g. "flip" or "mult") to filter. Click "Copy" to copy the numbered list.</footer>
</div>


<script>
const modules = [
'Half Adder', 'Full Adder', 'Half Subtractor', 'Full Subtractor', '4-bit Adder Subtractor',
'Carry Look Ahead Adder', 'Binary to Gray Code Converter', 'Gray to Binary Code Converter', 'Multiplexer', 'Demultiplexer',
'Encoder', 'Decoder', 'Comparator', 'Array Multiplier', "Booth's Multiplier", 'Wallace Tree Multiplier',
'D-Flip Flop with Async Reset', 'D-Flip Flop with Sync Reset', 'SR Flip Flop', 'JK Flip Flop', 'T Flip Flop',
'Universal Shift Register', 'Linear Feedback Shift Register (LFSR)', 'Asynchronous Counter', 'Synchronous Counter',
'Mealy Sequence Detector', 'Moore Sequence Detector', 'Synchronous FIFO', 'Asynchronous FIFO', 'UART'
];


const grid = document.getElementById('grid');
function render(list){
grid.innerHTML = '';
list.forEach((name, idx) => {
const card = document.createElement('article');
card.className = 'card';
card.tabIndex = 0;
card.innerHTML = `
<div class="badge">${String(idx+1).padStart(2,'0')}</div>
<div style="flex:1">
<h3 class="name">${name}</h3>
</html>

