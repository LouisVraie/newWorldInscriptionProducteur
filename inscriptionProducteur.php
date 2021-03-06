<?php

require_once "fonctions.php";

if(isset($_POST['nom']) && isset($_POST['prenom']) && 
isset($_POST['adresse']) && isset($_POST['rue']) && isset($_POST['codePostal']) && isset($_POST['ville']) &&
isset($_POST['longitude']) && isset($_POST['latitude']) && 
isset($_POST['mail']) && isset($_POST['tel']) && isset($_POST['siren']) &&
isset($_POST['mdp']) && isset($_POST['cMdp'])){

    echo 'Tout est set ! ';
    $nom = $_POST['nom'];
    $prenom = $_POST['prenom'];
    $rue = $_POST['rue'];
    $ville = $_POST['ville'];
    $cp = $_POST['codePostal'];
    $mail = $_POST['mail'];
    $tel = $_POST['tel'];
    $mdp = $_POST['mdp'];
    $siren = $_POST['siren'];
    $latitude = $_POST['latitude'];
    $longitude = $_POST['longitude'];

    //on insère le producteur en base
    $infosProducteur = insertProducteur($nom,$prenom,$rue,$ville,$cp,$mail,$tel,$mdp,$siren,$latitude,$longitude);

    //si l'insertion a fonctionné
    if(isset($infosProducteur['nom'])){
        echo 'Insertion OK ! ';
        if($message = sendConfirmationMail($infosProducteur['nom'],$infosProducteur['prenom'],$infosProducteur['mail'],$infosProducteur['codeConfirmation'])){
            echo 'Mail envoyé ! ';
            echo $message;
        }
    } else {
        echo $infosProducteur['error'];
    }
} else {
    echo 'Tous n\'est pas set';
}

?>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/newWorldInscriptionProducteur.css" type="text/css">
    <title>Inscription Producteur - CircuitsCourts</title>
    <!-- JQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"> </script>
        <script 
        src = "https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"
        integrity = "sha256-hlKLmzaRlE8SCJC1Kw8zoUbU8BxA+8kR3gseuKfMjxA="
        crossorigin = "anonymous" >
    </script>
</head>

<body>
    <h1>Inscription Producteur</h1>
    <div id="formContainer">
        <form action="inscriptionProducteur.php" method="post">
            <div>
                <label for="nom">Nom* :</label>
                <input type="text" id="nom" name="nom" placeholder="Votre nom..." maxlength="30" 
                pattern="(^[A-Z]{1}[a-z]+)$|([A-Z]{1}[a-z]+-?[A-Z]{1}[a-z]+)$" oninput="controlNom()" required />
                <p id="erreurNom" class="erreur"></p>
            </div>
            <div>
                <label for="prenom">Prénom* :</label>
                <input type="text" id="prenom" name="prenom" placeholder="Votre prénom..." maxlength="30" 
                pattern="(^[A-Z]{1}[a-z]+)$|([A-Z]{1}[a-z]+-?[A-Z]{1}[a-z]+)$" oninput="controlPrenom()" required />
                <p id="erreurPrenom" class="erreur"></p>
            </div>
            <div>
                <label for="adresse">Adresse* :</label>
                <input type="text" class="ui-autocomplete-input" id="adresse" name="adresse" autocomplete="off" placeholder="Votre adresse..." required  />
                <input type="hidden" id="rue" name="rue" placeholder="" required />
                <input type="hidden" id="codePostal" name="codePostal" placeholder="" required />
                <input type="hidden" id="ville" name="ville" placeholder="" required />
                <input type="hidden" id="longitude" name="longitude" placeholder="" required />
                <input type="hidden" id="latitude" name="latitude" placeholder="" required />
                <p id="erreurAdresse" class="erreur"></p>
            </div>
            <div>
                <label for="siren">N° SIREN* :</label>
                <input type="text" id="siren" name="siren" placeholder="Votre N°SIREN..." pattern="[0-9]{9}" maxlength="9" 
                oninput="controlSIREN()" required />
                <p id="erreurSiren" class="erreur"></p>
            </div>
            <div>
                <label for="mail">Mail* :</label>
                <input type="email" id="mail" name="mail" placeholder="Votre adresse mail..." pattern="^[\w\-\.]+@([\w-]+\.)+[\w-]{2,4}$" 
                oninput="controlMail()" required />
                <p id="erreurMail" class="erreur"></p>
            </div>
            <div>
                <label for="tel">Tél* :</label>
                <input type="tel" id="tel" name="tel" placeholder="Votre numero de téléphone..." required />
                <p id="erreurTel" class="erreur"></p>
            </div>
            <div>
                <label for="mdp">Mot de passe* :</label>
                <input type="password" id="mdp" name="mdp" placeholder="Votre mot de passe..." pattern="^(?=.*[A-Z])(?=.*[!?@#$&*,_*-+])(?=.*[0-9])(?=.*[a-z]).{8,}$" 
                oninput="controlMdp()" required />
                <p id="erreurMdp" class="erreur"></p>
            </div>
            <div>
                <label for="cmdp">Confirmation de mot de passe* :</label>
                <input type="password" id="cMdp" name="cMdp" placeholder="Votre mot de passe..." pattern="^(?=.*[A-Z])(?=.*[!?@#$&*,_*-+])(?=.*[0-9])(?=.*[a-z]).{8,}$" 
                oninput="controlCMdp()" required />
                <p id="erreurCMdp" class="erreur"></p>
            </div>
            <div>
                <button type="submit">Valider</button>
            </div>
        </form>
    </div>
</body>

<script src="./js/newWorldInscriptionProducteur.js"></script>

</html>