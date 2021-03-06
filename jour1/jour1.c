/* Fichier du jour de l’AoC 2015
 * @file jour1.c
 * @author rick <rick@gnous.eu>
 * @date 2021
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#define FILEINPUT "input"

void p_partie(FILE *file_ptr);
void d_partie(FILE *file_ptr);

int main()
{
  FILE *file_ptr = fopen(FILEINPUT, "r");
  if (errno)
  {
    perror(NULL);
    return 1;
  }

  printf("Traitement de la première partie…\n");
  p_partie(file_ptr);
  fseek(file_ptr, 0, SEEK_SET); /* Pour revenir au début du fichier */
  printf("Traitement de la deuxième partie…\n");
  d_partie(file_ptr);

  fclose(file_ptr);
  return 0;
}

void p_partie(FILE *file_ptr)
{
  int floor = 0;
  char parenthese;
  while (!feof(file_ptr))
  {
    parenthese = (char) fgetc(file_ptr);
    if (parenthese == '(')
      floor++;
    else if (parenthese == ')')
      floor--;
  }

  printf("Nous sommes à l’étage %d.\n", floor);
}

void d_partie(FILE *file_ptr)
{
  int floor = 0, nb_char = 0;
  char parenthese;
  while (!feof(file_ptr) && floor >= 0)
  {
    parenthese = (char) fgetc(file_ptr);
    if (parenthese == '(')
      floor++;
    else if (parenthese == ')')
      floor--;

    nb_char++;
  }

  printf("La parenthèse numéro %d nous met dans le sous sol.\n", nb_char);
}
