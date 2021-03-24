const fs = require('fs');

try {
  const file = fs.readFileSync("input", "utf8");
  const data = JSON.parse(file);
  console.log("Traitement de la première partie…");
  console.log("La somme totale est " + parseJsonPrem(data));
  console.log("Traitement de la deuxième partie…");
  console.log("La somme totale est " + parseJsonDeux(data));
} catch(err) {
  console.log("Une erreur a été rencontrée !");
  console.error(err);
}

/**
 * Fonction additionnant tous les nombres contenus dans un objet
 * de type Array ou JSON.
 *
 * @param Object obj - Object où se trouve des nombres
 * @return int la somme totale
 */
function parseJsonPrem(obj) {
  let ret = 0;
  let value;

  for (const index in obj) {
    value = obj[index];
    if (value instanceof Object) { // car Array est un Object
      ret += parseJsonPrem(value);
    } else if (Number.isInteger(value)) {
      ret += value;
    }
  }
  return ret;
}

/**
 * Fonction additionnant tous les nombres contenus dans un objet
 * sauf ceux qui ont une propriété "red". Règle ne s’appliquant pas 
 * aux Array (toujours une addition complète)
 *
 * @param Object obj - Object où se trouve des nombres
 * @return int la somme totale
 */
function parseJsonDeux(obj) {
  let ret = 0;
  let value;

  // c’est plus jolie d’avoir une variable dédiée plutot que bourrer le if
  let isObj = !(obj instanceof Array) && obj instanceof Object;

  for (const index in obj) {
    value = obj[index];
    if (value instanceof Object) {
      ret += parseJsonDeux(value);
    } else if (Number.isInteger(value)) {
      ret += value;
    } else if (isObj && value === "red") {
      ret = 0;
      break;
    }
  }
  return ret;
}
