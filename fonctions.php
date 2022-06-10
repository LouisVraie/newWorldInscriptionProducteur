<?php
    require_once "./dbConnexion.php";

    /**
 * Définit le prochain identifiant d'un enregistrement de la table donnée
 * 
 * @param string $table Nom de la table
 * @param string $idColumnName Nom de la colonne clé primaire. default 'id'
 * @param string $iteration Décalage entre chaque identifiant. default 1
 * 
 * @return int $id
 */
function setNextId($table, $idColumnName = 'id', $iteration = 1)
{
    global $pdo;
	try {
        $req = $pdo->prepare("SELECT IFNULL(MAX(".$idColumnName.")+:iteration,1) as id FROM ".$table);
		$req->bindValue(':iteration',$iteration);

        $req->execute();
		$id = $req->fetch(PDO::FETCH_ASSOC);
		return $id['id'];
	} catch (\Exception $error) {
        return ['error' => $error];
	} catch (\PDOException $error) {
        return ['error' => $error];
	}
}

/**
 * Fonction qui retourne la date du jour au format yyyy-MM-dd
 * 
 * @return string 
 */
function todayDate(){
    return date("Y-m-d");
}

/**
 * Crée une chaîne de caractères aléatoires d'une longueur donnée
 * 
 * @param int $length La longueur de la chaîne de caractères
 * 
 * @return string
 */
function randomCode($length){
    return substr(base64_encode(bin2hex(random_bytes($length))),0,$length);
}

/**
 * Insère le producteur dans la base de données
 * 
 * @param string $nom
 * @param string $prenom
 * @param string $rue
 * @param string $ville
 * @param string $cp
 * @param string $mail
 * @param string $tel
 * @param string $mdp
 * @param string $siren
 * @param string $latitude
 * @param string $longitude
 * 
 * @return array
 */
function insertProducteur($nom,$prenom,$rue,$ville,$cp,$mail,$tel,$mdp,$siren,$latitude,$longitude){
    global $pdo;
    try{
        $numProd = setNextId('Producteur','numeroProducteur');
        $date = todayDate();
        $codeConfirmation = randomCode(40);
        $numAct = '0113Z';
        $textInsert = "INSERT INTO Producteur (numeroProducteur,nomProducteur,prenomProducteur,adresseProducteur,villeProducteur, 
                      codePostalProducteur,mailProducteur,telProducteur,mdpProducteur,dateInscriptionProducteur,numeroSirenProducteur,
                      codeConfirmationMailProducteur,latitudeProducteur,longitudeProducteur,numeroActivite) 
                      VALUES (:numProd,:nom,:prenom,:rue,:ville,:cp,:mail,:tel,PASSWORD(':mdp'),:dateInscription,:siren,:codeConfirmationMail,:latitude,:longitude,:numAct)";
        $reqInsert = $pdo->prepare($textInsert);
        $reqInsert->bindValue(':numProd',$numProd);
        $reqInsert->bindValue(':nom',$nom);
        $reqInsert->bindValue(':prenom',$prenom);
        $reqInsert->bindValue(':rue',$rue);
        $reqInsert->bindValue(':ville',$ville);
        $reqInsert->bindValue(':cp',$cp);
        $reqInsert->bindValue(':mail',$mail);
        $reqInsert->bindValue(':tel',$tel);
        $reqInsert->bindValue(':mdp',$mdp);
        $reqInsert->bindValue(':dateInscription',$date);
        $reqInsert->bindValue(':siren',$siren);
        $reqInsert->bindValue(':codeConfirmationMail',$codeConfirmation);
        $reqInsert->bindValue(':latitude',$latitude);
        $reqInsert->bindValue(':longitude',$longitude);
        $reqInsert->bindValue(':numAct',$numAct);
        
        if($reqInsert->execute()){
            $tab = [
                'nom' => $nom,
                'prenom' => $prenom,
                'mail' => $mail,
                'codeConfirmation' => $codeConfirmation
            ];
        } else {
            $tab = ['error' => 'L\'insertion du producteur a échoué ! '.$numProd." ".$date];
        }
        $reqInsert->debugDumpParams();
        return $tab; 

    }catch(Exception $e){
        return ['error' => $e];
    }

}

/**
 * Envoi un mail de confirmation au producteur donné
 * 
 * @param string $nom
 * @param string $prenom
 * @param string $mail
 * @param string $codeConfirmation
 * 
 * @return bool
 */
function sendConfirmationMail($nom,$prenom,$mail,$codeConfirmation){
    // Plusieurs destinataires
    $to = $mail; // notez la virgule

    // Sujet
    $subject = 'NewWorld - Confirmation d\'inscription';

    // message
    $message = '
    <html>
        <head>
        <title>NewWorld - Confirmation d\'inscription</title>
        </head>
        <body>
        <p>Vous vous êtes inscrit sur notre application Circuits Courts.</p>
        <p>Veuillez confirmer votre email pour que votre inscription soit prise en compte</p>
        <a href="https://www.google.com?codeConfirmation=';
        $message.= $codeConfirmation;
        $message.='">Cliquez ici pour confirmer votre email</a>
        </body>
    </html>
    ';

    // Pour envoyer un mail HTML, l'en-tête Content-type doit être défini
    $headers[] = 'MIME-Version: 1.0';
    $headers[] = 'Content-type: text/html; charset=utf-8';

    // En-têtes additionnels
    $headers[] = "To: ".$prenom." ".$nom." <".$mail.">";
    $headers[] = 'From: NewWorld <newworld@btsinfogap.org>';

    // Envoi
    mail($to, $subject, $message, implode("\r\n", $headers));
    return $message;
}
?>