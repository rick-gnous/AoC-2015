Module mainModule
    Sub Main()
        Const NbIt As Integer = 50
        ' NbOcc à modifier, contient le nombre d’itération à faire'
        ' MyInput contient la chaine d’entrée
        ' Builder construit la chaine suivante
        ' occ est le nombre d’occurence d’un nombre
        ' i et j sont des itérateurs pour le nombre de fois à faire 
        ' le programme et le parcours de la chaine 
        ' actChar est le caractère courant
        Dim MyInput As String = "1113222113"
        Dim Builder As New System.Text.StringBuilder
        Dim occ As Integer
        Dim i As Integer
        Dim j As Integer = 0
        Dim actChar as Char

        Do While i < NbIt 
            Builder.Clear()
            Console.WriteLine("Etape numero : {0}", i)
            j = 1
            Do
                occ = 1
                actChar = GetChar(MyInput, j)
                Try
                    If GetChar(MyInput, j + 1) = actChar Then
                        If GetChar(MyInput, j + 2) = actChar Then
                            occ = 3
                        Else
                            occ = 2
                        End if
                    End If
                Catch 
                End Try
                Builder.Append(occ & actChar)

                j += occ
            Loop Until j > Len(MyInput)
            i += 1
            MyInput = Builder.ToString()
        Loop
        Console.WriteLine("Le resultat est {0}", Len(MyInput))
    End Sub
End Module
