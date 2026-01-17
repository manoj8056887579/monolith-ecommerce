# Monolith E-Commerce Application Startup Script
# Starts Backend Monolith and Frontend

$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path

$Services = @(
    "backend",
    "frontend"
)

Write-Host ""
Write-Host "╔════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   Monolith E-Commerce Application Startup     ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

Write-Host "[1/3] Checking dependencies..." -ForegroundColor Yellow
foreach ($service in $Services) {
    $servicePath = Join-Path $ScriptPath $service
    $packagePath = Join-Path $servicePath "package.json"
    
    if (Test-Path $packagePath) {
        Write-Host "      ✓ $service" -ForegroundColor Green
        Push-Location $servicePath
        
        # Check if node_modules exists
        $nodeModulesPath = Join-Path $servicePath "node_modules"
        if (-not (Test-Path $nodeModulesPath)) {
            Write-Host "        Installing dependencies..." -ForegroundColor Yellow
            npm install --silent 2>&1 | Out-Null
        }
        
        Pop-Location
    }
}

Write-Host ""
Write-Host "[2/3] Generating Prisma Client..." -ForegroundColor Yellow
Push-Location (Join-Path $ScriptPath "backend")
npx prisma generate 2>&1 | Out-Null
Write-Host "      ✓ Prisma client generated" -ForegroundColor Green
Pop-Location

Write-Host ""
Write-Host "[3/3] Ready to start!" -ForegroundColor Green
Write-Host ""
Write-Host "═══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "🚀 Start Application (VS Code):" -ForegroundColor Yellow
Write-Host ""
Write-Host "  1. Press: Ctrl + Shift + P" -ForegroundColor White
Write-Host "  2. Type:  Tasks: Run Task" -ForegroundColor White
Write-Host "  3. Select: Start Monolith Application" -ForegroundColor White
Write-Host ""
Write-Host "═══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "🔧 Or run manually:" -ForegroundColor Yellow
Write-Host ""
Write-Host "  Backend:   cd backend && npm run dev" -ForegroundColor White
Write-Host "  Frontend:  cd frontend && npm run dev" -ForegroundColor White
Write-Host ""
Write-Host "═══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "📡 Application URLs:" -ForegroundColor Yellow
Write-Host ""
Write-Host "  Frontend:  http://localhost:3000" -ForegroundColor Green
Write-Host "  Backend:   http://localhost:5000" -ForegroundColor Green
Write-Host "  API Docs:  http://localhost:5000/api" -ForegroundColor Green
Write-Host ""
Write-Host "═══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
