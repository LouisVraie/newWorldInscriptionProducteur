//removeAccents 
function removeAccents(text){
    const accentsMap = new Map([
    ["A", "Á|À|Ã|Â|Ä"],
    ["a", "á|à|ã|â|ä"],
    ["E", "É|È|Ê|Ë"],
    ["e", "é|è|ê|ë"],
    ["I", "Í|Ì|Î|Ï"],
    ["i", "í|ì|î|ï"],
    ["O", "Ó|Ò|Ô|Õ|Ö"],
    ["o", "ó|ò|ô|õ|ö"],
    ["U", "Ú|Ù|Û|Ü"],
    ["u", "ú|ù|û|ü"],
    ["C", "Ç"],
    ["c", "ç"],
    ["N", "Ñ"],
    ["n", "ñ"]
  ]);
  
  const reducer = (acc, [key]) => acc.replace(new RegExp(accentsMap.get(key), "g"), key);
  return [...accentsMap].reduce(reducer, text);
}

/**
 * 
 * Contrôle des saisies
 * 
 */
const regexNomPrenom = /(^[A-Z]{1}[a-z]+)$|([A-Z]{1}[a-z]+-?[A-Z]{1}[a-z]+)$/g;
const regexSiren = /[0-9]{9}/g;
const regexMail = /^[\w\-\.]+@([\w-]+\.)+[\w-]{2,4}$/g;
const regexMdp = /^(?=.*[A-Z])(?=.*[!?@#$&*,_*-+])(?=.*[0-9])(?=.*[a-z]).{8,}$/g;

//Nom
function controlNom() {
    var iNom = document.getElementById('nom');
    var nom = iNom.value;
    var erreurNom = document.getElementById('erreurNom');
    //si la taille minimale requise et le format sont incorrect
    if (nom.length < 2 || nom.match(regexNomPrenom) == null) {
        var message = "Votre nom est incorrect ! Ex : Dupond";
        iNom.setCustomValidity(message);
        erreurNom.innerHTML = message;
    } else {
        iNom.setCustomValidity('');
        erreurNom.innerHTML = "";
    }
}
//Prénom
function controlPrenom() {
    var iPrenom = document.getElementById('prenom');
    var prenom = iPrenom.value;
    var erreurPrenom = document.getElementById('erreurPrenom');
    //si la taille minimale requise et le format sont incorrect
    if (prenom.length < 2 || prenom.match(regexNomPrenom) == null) {
        var message = "Votre prénom est incorrect ! Ex : Jean";
        iPrenom.setCustomValidity(message);
        erreurPrenom.innerHTML = message;
    } else {
        iPrenom.setCustomValidity('');
        erreurPrenom.innerHTML = "";
    }
}

//Auto complément de l'adresse
$("#adresse").autocomplete({
    source: function (request, response) {
        $.ajax({
            url: "https://api-adresse.data.gouv.fr/search/?limit=5",
            data: { q: request.term },
            dataType: "json",
            success: function (data) {
                response($.map(data.features, function (item) {
                    return {
                        label: item.properties.label,
                        postcode: item.properties.postcode,
                        city: item.properties.city,
                        street: item.properties.street,
                        name: item.properties.name,
                        latitude: item.geometry.coordinates[1],
                        longitude: item.geometry.coordinates[0]
                    };
                }));
            }
        });
    },
    select: function (event, ui) {
        $('#codePostal').val(ui.item.postcode);
        $('#ville').val(ui.item.city);
        if (ui.item.street) {
            $('#rue').val(ui.item.street);
        } else {
            $('#rue').val(ui.item.name);
        }
        $('#latitude').val(ui.item.latitude);
        $('#longitude').val(ui.item.longitude);
    }
});

//N° SIREN
function controlSIREN() {
    var iSiren = document.getElementById('siren');
    var siren = iSiren.value;
    //si le numéro contient 9 chiffres
    if (siren.length === 9 && siren.match(regexSiren) != null) {
        //on crée une requête XMLHttp 
        var request = new XMLHttpRequest();
        var textRequestAjax = 'https://entreprise.data.gouv.fr/api/sirene/v3/etablissements/?etat_administratif=A&siren=' + siren;
        request.open('GET', textRequestAjax, true);
        request.setRequestHeader("Acces-control-Allow-Header", "*");
        request.setRequestHeader("Accept", "application/json");
        request.send();

        request.onreadystatechange = function (response) {
            if (request.readyState === 4) {
                //si la requête aboutie
                if (request.status === 200) {
                    iSiren.setCustomValidity('');
                    var tabJsonInfos = JSON.parse(request.responseText);
                    //si le résultat est unique
                    if (tabJsonInfos.meta.total_results == 1) {
                        //valeurs du formulaire
                        var rueForm = removeAccents(document.getElementById('rue').value.toUpperCase());
                        var codePostalForm = document.getElementById('codePostal').value;
                        var communeForm = removeAccents(document.getElementById('ville').value.toUpperCase());
                        //valeurs retournés par l'API
                        for (var noEtablissement = 0; noEtablissement < tabJsonInfos.etablissements.length; noEtablissement++) {
                            var rueSiren = removeAccents(tabJsonInfos.etablissements[noEtablissement].geo_l4.toUpperCase());
                            var codePostalSiren = tabJsonInfos.etablissements[noEtablissement].code_postal;
                            var communeSiren = removeAccents(tabJsonInfos.etablissements[noEtablissement].libelle_commune.toUpperCase());
                            //var codeNafSiren = tabJsonInfos.etablissements[noEtablissement].activite_principale;
                            //alert(rueForm+' '+rueSiren+' / '+ codePostalForm +' '+ codePostalSiren+' / '+ communeForm +' '+ communeSiren)
                            //si l'adresse saisie et l'adresse de la société correspondent
                            if (rueForm === rueSiren && codePostalForm === codePostalSiren && communeForm === communeSiren) {
                                iSiren.style.color = "green";
                                break;
                            } else {
                                iSiren.setCustomValidity('Le SIREN ne correspond pas !');
                                iSiren.style.color = "red";
                            }
                        }
                    }
                } else {
                    iSiren.setCustomValidity('Le SIREN \'est incorrect !');
                    iSiren.style.color = "red";
                    //alert('La requête n\'a pas aboutie ! Erreur '+request.status);
                }
            }
        };
    } else {
        iSiren.setCustomValidity('Le SIREN est composé de 9 chiffres');
    }
}

//Mail
function controlMail() {
    var iMail = document.getElementById('mail');
    var mail = iMail.value;
    var erreurMail = document.getElementById('erreurMail');
    //si la taille minimale requise et le format sont incorrect
    if (mail.length < 6 || mail.match(regexMail) == null) {
        var message = "Votre mail est incorrect ! Ex : mail@exemple.org";
        iMail.setCustomValidity(message);
        erreurMail.innerHTML = message;
    } else {
        iMail.setCustomValidity('');
        erreurMail.innerHTML = "";
    }
}


//Mot de passe
function controlMdp() {
    var iMdp = document.getElementById('mdp');
    var mdp = iMdp.value;
    var erreurMdp = document.getElementById('erreurMdp');
    //si la taille minimale requise et le format sont incorrect
    if (mdp.length < 8 || mdp.match(regexMdp) == null) {
        var message = "Votre mot de passe doit contenir au minimum 8 caractères !";
        iMdp.setCustomValidity(message);
        erreurMdp.innerHTML = message;
    } else {
        iMdp.setCustomValidity('');
        erreurMdp.innerHTML = "";
    }
}


//Confirmation du mot de passe
function controlCMdp() {
    var mdp = document.getElementById('mdp').value;
    var iCMdp = document.getElementById('cMdp');
    var cMdp = iCMdp.value;
    var erreurCMdp = document.getElementById('erreurCMdp');
    //si les mots de passe sont différents
    if (mdp != cMdp) {
        var message = "Vos mots de passe doivent être identiques !";
        iCMdp.setCustomValidity(message);
        erreurCMdp.innerHTML = message;
    } else {
        iCMdp.setCustomValidity('');
        erreurCMdp.innerHTML = "";
    }
}