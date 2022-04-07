<?php
//connexion à la base de données
try {
    $user = 'userCircuitsCourtsInscriptionProducteur';
    $pass = '98l@-coPD!m@nDe';
    $pdo = new PDO('mysql:host=localhost;dbname=dbCircuitsCourts', $user, $pass);
} catch (PDOException $e) {
    print "Erreur !: " . $e->getMessage() . "<br/>";
    die();
}
?>