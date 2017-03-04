#Cargamos las bibliotecas para trabajar con GLM, LDA y KNN
library('ISLR')
library('MASS')
library('class')
#Dividimos la data en 50% Training, 25 Validation data y 25% Testing para probar los modelos
#Validation set Holdout
data("Smarket")
idx1 <- sample (1:nrow(Smarket), 0.5*nrow(Smarket))
data.training <- Smarket[idx1, ]
data.other    <- Smarket[-idx1,]

idx2 <- sample (1:nrow(data.other), 0.5*nrow(data.other))
data.validation <- data.other[idx2, ]
data.testing    <- data.other[-idx2,]

#---------------------------------------------
#GLM GENERALIZED LINEAR MODEL
#---------------------------------------------

attach(data.training)
#1. Entrenamos el módelo
glm.fit <- glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume, data = data.training,family = binomial)
glm.fit2 <- glm(Direction ~ Lag1 + Lag2, data = data.training,family = binomial)

#2. Probamos el módelo, tratando de predecir con datos nuevos
glm.probs <- predict(glm.fit , data = data.validation,type = "response")
glm.probs2 <- predict(glm.fit2 , data = data.validation,type = "response")

#3. Creamos la matriz de confusión para evaluar la predicción del módelo
glm.pred <- rep("Down", nrow(data.training))
glm.pred[glm.probs > 0.5] = "Up"
glm.matriz_confusion <- table(glm.pred, Direction)

glm.pred2 <- rep("Down", nrow(data.training))
glm.pred2[glm.probs2 > 0.5] = "Up"
glm.matriz_confusion2 <- table(glm.pred2, Direction)

#4. Analizamos los resultados de la matriz de confusión


#4.1. Exactitud (Prevalence) para el modelo en general:
#Sin embargo, si las clases son muy diferentes, esta medida no significa nada
glm.exactitud <- (glm.matriz_confusion[1,1] + glm.matriz_confusion[2,2]) / sum(glm.matriz_confusion[])

#4.2. Sensitivity
#Medida de la completitud, que indica cuántos valores de la clase positiva fueron clasificados correctamente
glm.sensitivity <- glm.matriz_confusion[1,1]/ sum(glm.matriz_confusion[1,])


#4.3. Specificity
#indica cuántos valores de la clase negativa fueron clasificados correctamente
glm.specificity <- glm.matriz_confusion[2,2]/ sum(glm.matriz_confusion[2,])


glm.matriz_confusion
glm.exactitud
glm.sensitivity
glm.specificity

glm.matriz_confusion2
#---------------------------------------------
#LDA Latent Dirichlent Allocation (LDA)
#---------------------------------------------

#1. Entrenamos el módelo
lda.fit <- lda(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume, data = data.training)

#2. Probamos el módelo, tratando de predecir con datos nuevos
lda.probs <- predict(lda.fit , data = data.validation)

#3. Creamos la matriz de confusión para evaluar la predicción del módelo
lda.matriz_confusion <- table(lda.probs$class, Direction)

#4. Analizamos los resultados de la matriz de confusión

#4.1. Exactitud (Prevalence) para el modelo en general:
#Sin embargo, si las clases son muy diferentes, esta medida no significa nada
lda.exactitud <- (lda.matriz_confusion[1,1] + lda.matriz_confusion[2,2]) / sum(lda.matriz_confusion[])

#4.2. Sensitivity
#Medida de la completitud, que indica cuántos valores de la clase positiva fueron clasificados correctamente
lda.sensitivity <- lda.matriz_confusion[1,1]/ sum(lda.matriz_confusion[1,])


#4.3. Specificity
#indica cuántos valores de la clase negativa fueron clasificados correctamente
lda.specificity <- lda.matriz_confusion[2,2]/ sum(lda.matriz_confusion[2,])


lda.matriz_confusion
lda.exactitud
lda.sensitivity
lda.specificity

detach(data.training)
#---------------------------------------------
#KNN K-Nearest Neighbor
#---------------------------------------------

#idx1 <- sample (1:nrow(Smarket), 0.5*nrow(Smarket))

#1. Creamos una nueva data para evaluar KNN
idx1 = 1:625
data.training2 <- Smarket[-idx1,]
data.testing2  <- Smarket[idx1, ]
cl   <- data.training2$Direction[idx1]
cl2  <- data.testing2$Direction[idx1]

data.training2 <- data.training2[c(2,3,4,5,6)]
data.testing2  <- data.testing2 [c(2,3,4,5,6)]

#2. Le pasamos los datos al modelo
set.seed(1)
knn.pred = knn(data.training2, data.testing2, cl, k = 1, prob =TRUE)

#3. Creamos la matriz de confusión
knn.matriz_confusion <- table(knn.pred, cl)

#4. Analizamos los resultados de la matriz de confusión

#4.1. Exactitud (Prevalence) para el modelo en general:
#Sin embargo, si las clases son muy diferentes, esta medida no significa nada
knn.exactitud <- (knn.matriz_confusion[1,1] + knn.matriz_confusion[2,2]) / sum(knn.matriz_confusion[])

#4.2. Sensitivity
#Medida de la completitud, que indica cuántos valores de la clase positiva fueron clasificados correctamente
knn.sensitivity <- knn.matriz_confusion[1,1]/ sum(knn.matriz_confusion[1,])


#4.3. Specificity
#indica cuántos valores de la clase negativa fueron clasificados correctamente
knn.specificity <- knn.matriz_confusion[2,2]/ sum(knn.matriz_confusion[2,])


knn.matriz_confusion
knn.exactitud
knn.sensitivity
knn.specificity




#Comparamos los métodos

#--GLM--
glm.matriz_confusion
glm.exactitud
glm.sensitivity
glm.specificity

#--LDA--
lda.matriz_confusion
lda.exactitud
lda.sensitivity
lda.specificity

#--KNN--
knn.matriz_confusion
knn.exactitud
knn.sensitivity
knn.specificity

