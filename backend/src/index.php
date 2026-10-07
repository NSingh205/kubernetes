<?php
// index.php : the single entry point (front controller) of the backend.
declare(strict_types=1);

header('Content-Type: application/json');

function db(): PDO {
    // Connection details come from environment variables (set by docker-compose / Kubernetes).
    $host = getenv('DB_HOST') ?: 'db';
    $name = getenv('DB_NAME') ?: '';
    $user = getenv('DB_USER') ?: '';
    $pass = getenv('DB_PASSWORD') ?: '';

    return new PDO(
        "mysql:host=$host;dbname=$name;charset=utf8mb4",
        $user,
        $pass,
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );
}

$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

if ($path === '/api/health') {
    try {
        $now = db()->query('SELECT NOW() AS now')->fetch(PDO::FETCH_ASSOC);
        echo json_encode(['status' => 'ok', 'database' => 'connected', 'db_time' => $now['now']]);
    } catch (Throwable $e) {
        http_response_code(503);   // 503 = service unavailable
        echo json_encode(['status' => 'error', 'database' => 'unreachable']);
    }
    exit;
}

http_response_code(404);
echo json_encode(['error' => 'Not found', 'path' => $path]);
