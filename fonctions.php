<?php
    require_once "./dbConnexion.php";

    /**
 * Définit le prochain identifiant d'un enregistrement de la table donnée
 * 
 * @param string $table Nom de la table
 * @param string $idColumnName Nom de la colonne clé primaire. default 'id'
 * @param int $iteration Décalage entre chaque identifiant. default 1
 * 
 * @return int $id
 */
function setNextId($table, $idColumnName = 'id', $iteration = 1)
{
    global $pdo;
	try {
        $req = $pdo->prepare("SELECT IFNULL(MAX(:idColumnName)+:iteration,1) FROM :table");
		$req->bindValue(':idColumnName',$idColumnName,PDO::PARAM_STR);
		$req->bindValue(':table',$table,PDO::PARAM_STR);
		$req->bindValue(':iteration',$iteration,PDO::PARAM_INT);

        $req->execute();
		$id = $req->fetch(PDO::FETCH_ASSOC);
		return $id[0];
	} catch (\Exception $error) {
	}
}

function insertProducteur($nom,$prenom,$rue,$cp,$ville,$longitude,$latitude,$siren,$mail,$tel,$mdp){
    global $pdo;
    try{
        $numProd = setNextId('Producteur','numeroProducteur');
        $textInsert = "INSERT INTO Producteur (numeroProducteur,nomProducteur,prenomProducteur,adresseProducteur,villeProducteur, 
                      codePostalProducteur,mailProducteur,telProducteur,mdpProducteur,dateInscriptionProducteur,numeroSirenProducteur,
                      codeConfirmationMailProducteur,latitudeProducteur,longitudeProducteur,numeroActivite) 
                      VALUES (:numProd,:nom,:prenom,:rue,:ville,:cp,:mail,:tel,PASSWORD(':mdp'),:dateInscription,:siren,:codeConfirmationMail,:latitude,:longitude,:numAct)";
        $reqInsert = $pdo->prepare($textInsert);
        $reqInsert->bindValue(':numProd',$numProd,PDO::PARAM_INT);
        $reqInsert->bindValue(':nom',$numProd,PDO::PARAM_STR);
        $reqInsert->bindValue(':prenom',$numProd,PDO::PARAM_STR);
        $reqInsert->bindValue(':rue',$numProd,PDO::PARAM_STR);
        $reqInsert->bindValue(':ville',$numProd,PDO::PARAM_STR);
        $reqInsert->bindValue(':cp',$numProd,PDO::PARAM_STR);
        $reqInsert->bindValue(':mail',$numProd,PDO::PARAM_STR);
        $reqInsert->bindValue(':tel',$numProd,PDO::PARAM_STR);
        $reqInsert->bindValue(':mdp',$numProd,PDO::PARAM_STR);
        $reqInsert->bindValue(':dateInscription',$numProd,PDO::PARAM_STR);
        $reqInsert->bindValue(':siren',$numProd,PDO::PARAM_STR);
        $reqInsert->bindValue(':codeConfirmationMail',$numProd,PDO::PARAM_STR);
        $reqInsert->bindValue(':latitude',$numProd,PDO::PARAM_INT);
        $reqInsert->bindValue(':longitude',$numProd,PDO::PARAM_INT);
        $reqInsert->bindValue(':numAct','0113Z',PDO::PARAM_STR);

        $reqInsert->execute();

    }catch(Exception $e){

    }

}
?>