<?php

// For local timezone
// @see https://carbon.nesbot.com/docs/#api-instantiation
// @see https://www.php.net/manual/en/function.date-default-timezone-set.php
date_default_timezone_set('Asia/Seoul');

$candidates = [
    getcwd().'/vendor/autoload.php',
];

// To avoid class version conflict in a PHP project which already has Psy\Sehll
//
// [2020-03-06 16:57:14] local.ERROR: Symfony\Component\Debug\Exception\FatalThrowableError: Call to undefined method Psy\Configuration::useTabCompletion() in /Users/juwon.kim/.composer/vendor/psy/psysh/src/Shell.php:1279
//Stack trace:
//#0 /Users/juwon.kim/.composer/vendor/psy/psysh/src/Shell.php(305): Psy\Shell->initializeTabCompletion()
if (!class_exists(Psy\Shell::class)) {
    $candidates[] = getenv('HOME').'/.composer/vendor/autoload.php';
}

foreach ($candidates as $c) {
    if (file_exists($c)) {
        require_once($c);
    }
}

return [
    'startupMessage' => sprintf('<info>%s</info>', shell_exec('uptime')),
];
