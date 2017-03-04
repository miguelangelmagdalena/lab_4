Comparación entre GLM, LDA y KNN

Dado un dataset de la biblioteca ISLR llamado Smarket,
dividimos la data para poder entrenar el modelo y luego
probarlo. 

Luego de eso obtuvimos los siguientes resultados 

Con la exactitud, podemos observar la proporción del numero
total de predicciones que fueron correctas, y en este caso
podemos notar que en glm y lda tenemos la misma exactitud
pero en knn es un poco menor, sin embargo si la separación
de las clases es muy grande, Es decir tenemos 1000 observaciones
correspondientes a up y 100 a down, no tenemos las clases 
balanceadas y con la exactitud solo se tomaría en cuenta las 
predicciones correctas del caso UP

Por otro lado la sensitivity es la proporcion de casos negativos
que fueron clasificados correctamente, y en este dataset seria
los casos correctamente clasificados de la clase Down, y lda 
supera a glm por algunas décimas y knn se queda por debajo

Luego tenemos la specificity que que es la proporcion de casos
positivos que fueron clasificados correctamente, serian la clase
UP y podemos notar que entre glm y lda es mejor glm pero knn 
clasifica a los UP un poco mejor

En fin, podemos concluir que para este dataset lda y glm se
adaptan mucho mejor que knn