/*Ajout d'un champ numéro de SIREN à la table Producteur*/
ALTER TABLE Producteur ADD COLUMN numeroSirenProducteur INT(9) NOT NULL;
/*Champ pour savoir si l'email a été confirmé*/
ALTER TABLE Producteur ADD COLUMN confirmationMailProducteur BOOL NOT NULL DEFAULT FALSE;
/*Champ pour stocker le code de confirmation de l'email*/
ALTER TABLE Producteur ADD COLUMN codeConfirmationMailProducteur VARCHAR(40);
/*Champ pour stocker la latitude*/
ALTER TABLE Producteur ADD COLUMN latitudeProducteur DOUBLE(8,5);
/*Champ pour stocker la longitude*/
ALTER TABLE Producteur ADD COLUMN longitudeProducteur DOUBLE(8,5);

/*Changement de la taille max du nom et du prénom */
ALTER TABLE Producteur MODIFY COLUMN nomProducteur VARCHAR(30);
ALTER TABLE Producteur MODIFY COLUMN prenomProducteur VARCHAR(30);

/* Ajout de la table Activité qui contient les codes NAF*/
CREATE TABLE Activite (
    numeroActivite VARCHAR(5) NOT NULL,
    libelleActivite VARCHAR(100),
    PRIMARY KEY(numeroActivite)
);
/* Ajout d'une colonne numeroActivite en référence à numeroActivite de la table Activite*/
ALTER TABLE Producteur ADD COLUMN numeroActivite VARCHAR(5) NOT NULL;
ALTER TABLE Producteur ADD CONSTRAINT FK_numeroActivite FOREIGN KEY(numeroActivite) REFERENCES Activite(numeroActivite);

/* Ajout des différentes activités autorisées */
INSERT INTO Activite VALUES ('0111Z','Culture de céréales (à l''exception du riz), de légumineuses et de graines oléagineuses');
INSERT INTO Activite VALUES ('0112Z','Culture du riz');
INSERT INTO Activite VALUES ('0113Z','Culture de légumes, de melons, de racines et de tubercules');
INSERT INTO Activite VALUES ('0114Z','Culture de la canne à sucre');
INSERT INTO Activite VALUES ('0115Z','Culture du tabac');
INSERT INTO Activite VALUES ('0116Z','Culture de plantes à fibres');
INSERT INTO Activite VALUES ('0119Z','Autres cultures non permanentes');
INSERT INTO Activite VALUES ('0121Z','Culture de la vigne');
INSERT INTO Activite VALUES ('0122Z','Culture de fruits tropicaux et subtropicaux');
INSERT INTO Activite VALUES ('0123Z','Culture d''agrumes');
INSERT INTO Activite VALUES ('0124Z','Culture de fruits à pépins et à noyau');
INSERT INTO Activite VALUES ('0125Z','Culture d''autres fruits d''arbres ou d''arbustes et de fruits à coque');
INSERT INTO Activite VALUES ('0126Z','Culture de fruits oléagineux');
INSERT INTO Activite VALUES ('0127Z','Culture de plantes à boissons');
INSERT INTO Activite VALUES ('0128Z','Culture de plantes à épices, aromatiques, médicinales et pharmaceutiques');
INSERT INTO Activite VALUES ('0129Z','Autres cultures permanentes');
INSERT INTO Activite VALUES ('0130Z','Reproduction de plantes');
INSERT INTO Activite VALUES ('0141Z','Élevage de vaches laitières');
INSERT INTO Activite VALUES ('0142Z','Élevage d''autres bovins et de buffles');
INSERT INTO Activite VALUES ('0143Z','Élevage de chevaux et d''autres équidés');
INSERT INTO Activite VALUES ('0144Z','Élevage de chameaux et d''autres camélidés');
INSERT INTO Activite VALUES ('0145Z','Élevage d''ovins et de caprins');
INSERT INTO Activite VALUES ('0146Z','Élevage de porcins');
INSERT INTO Activite VALUES ('0147Z','Élevage de volailles');
INSERT INTO Activite VALUES ('0149Z','Élevage d''autres animaux');
INSERT INTO Activite VALUES ('0150Z','Culture et élevage associés');
INSERT INTO Activite VALUES ('0170Z','Chasse, piégeage et services annexes');
INSERT INTO Activite VALUES ('0230Z','Récolte de produits forestiers non ligneux poussant à l''état sauvage');
INSERT INTO Activite VALUES ('0311Z','Pêche en mer');
INSERT INTO Activite VALUES ('0312Z','Pêche en eau douce');
INSERT INTO Activite VALUES ('0321Z','Aquaculture en mer');
INSERT INTO Activite VALUES ('0322Z','Aquaculture en eau douce');
INSERT INTO Activite VALUES ('0893Z','Production de sel');
INSERT INTO Activite VALUES ('1011Z','Transformation et conservation de la viande de boucherie');
INSERT INTO Activite VALUES ('1012Z','Transformation et conservation de la viande de volaille');
INSERT INTO Activite VALUES ('1013B','Charcuterie');
INSERT INTO Activite VALUES ('1020Z','Transformation et conservation de poisson, de crustacés et de mollusques');
INSERT INTO Activite VALUES ('1031Z','Transformation et conservation de pommes de terre');
INSERT INTO Activite VALUES ('1032Z','Préparation de jus de fruits et légumes');
INSERT INTO Activite VALUES ('1039A','Autre transformation et conservation de légumes');
INSERT INTO Activite VALUES ('1039B','Transformation et conservation de fruits');
INSERT INTO Activite VALUES ('1041A','Fabrication d''huiles et graisses brutes');
INSERT INTO Activite VALUES ('1041B','Fabrication d''huiles et graisses raffinées');
INSERT INTO Activite VALUES ('1042Z','Fabrication de margarine et graisses comestibles similaires');
INSERT INTO Activite VALUES ('1051A','Fabrication de lait liquide et de produits frais');
INSERT INTO Activite VALUES ('1051B','Fabrication de beurre');
INSERT INTO Activite VALUES ('1051C','Fabrication de fromage');
INSERT INTO Activite VALUES ('1051D','Fabrication d''autres produits laitiers');
INSERT INTO Activite VALUES ('1052Z','Fabrication de glaces et sorbets');
INSERT INTO Activite VALUES ('1061A','Meunerie');
INSERT INTO Activite VALUES ('1061B','Autres activités du travail des grains');
INSERT INTO Activite VALUES ('1062Z','Fabrication de produits amylacés');
INSERT INTO Activite VALUES ('1071C','Boulangerie et boulangerie-pâtisserie');
INSERT INTO Activite VALUES ('1071D','Pâtisserie');
INSERT INTO Activite VALUES ('1072Z','Fabrication de biscuits, biscottes et pâtisseries de conservation');
INSERT INTO Activite VALUES ('1073Z','Fabrication de pâtes alimentaires');
INSERT INTO Activite VALUES ('1081Z','Fabrication de sucre');
INSERT INTO Activite VALUES ('1082Z','Fabrication de cacao, chocolat et de produits de confiserie');
INSERT INTO Activite VALUES ('1083Z','Transformation du thé et du café');
INSERT INTO Activite VALUES ('1084Z','Fabrication de condiments et assaisonnements');
INSERT INTO Activite VALUES ('1085Z','Fabrication de plats préparés');
INSERT INTO Activite VALUES ('1086Z','Fabrication d''aliments homogénéisés et diététiques');
INSERT INTO Activite VALUES ('1089Z','Fabrication d''autres produits alimentaires n.c.a.');
INSERT INTO Activite VALUES ('1101Z','Production de boissons alcooliques distillées');
INSERT INTO Activite VALUES ('1102A','Fabrication de vins effervescents');
INSERT INTO Activite VALUES ('1102B','Vinification');
INSERT INTO Activite VALUES ('1103Z','Fabrication de cidre et de vins de fruits');
INSERT INTO Activite VALUES ('1104Z','Production d''autres boissons fermentées non distillées');
INSERT INTO Activite VALUES ('1105Z','Fabrication de bière');
INSERT INTO Activite VALUES ('1106Z','Fabrication de malt');
INSERT INTO Activite VALUES ('1107B','Production de boissons rafraîchissantes');