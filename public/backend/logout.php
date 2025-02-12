<?php
session_start();
session_destroy();
$wylogowano = true;
echo (json_encode($wylogowano));
