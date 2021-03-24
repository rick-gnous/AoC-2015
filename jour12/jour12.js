const fs = require('fs');

try {
  const file = fs.readFileSync("input", "utf8");
  const data = JSON.parse(file);
  console.log("Traitement de la première partie…");
  console.log("La somme totale est " + parseJsonPrem(data));
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

/*
function parseObject(objet) {
  let ret = 0;
  let value;

  for (const index in obj) {
    value = obj[index];
    if (value instanceof Array) {
      ret += parseArray(value);
    } else if (value instanceof Object) {
      ret += parseObject(value);
    } else if (Number.isInteger(value)) {
      ret += value;
    }
  }
  return ret;
}
*/
