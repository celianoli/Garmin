


````markdown
# 🚀 Guide rapide  Pousser un projet sur GitHub

Ce guide explique étape par étape comment envoyer (pousser) un projet local vers un dépôt GitHub.

---

## 1. Se placer dans le dossier du projet
```bash
cd chemin/vers/ton/projet
````

Exemple 

```bash
cd C:\Users\celian\Desktop\celian\Projet
```

---

## 2. Initialiser Git

```bash
git init
```

Cela crée un dossier `.git` caché qui suit les versions du projet.

---

## 3. Ajouter le dépôt distant (GitHub)

```bash
git remote add origin https://github.com/UTILISATEUR/NOM_DU_REPO.git
```

Exemple 

```bash
git remote add origin https://github.com/celianoli/Garmin.git
```

---

## 4. Configurer ton identité (nom + email)

⚠️ Important  utiliser le même email que sur GitHub pour que les commits soient liés à ton compte.

```bash
git config --global user.name ton_nom_utilisateur
git config --global user.email ton_email@exemple.com
```

---

## 5. Ajouter les fichiers à suivre

 Pour ajouter un fichier précis 

```bash
git add monfichier.txt
```

 Pour ajouter tout le dossier 

```bash
git add .
```

---

## 6. Créer un commit (sauvegarde locale)

```bash
git commit -m Message décrivant les changements
```

Exemple 

```bash
git commit -m Ajout du dossier pour tester sur pcportable
```

---

## 7. Envoyer (pousser) sur GitHub

```bash
git branch -M main
git push -u origin main
```

---

## ✅ Résultat

Ton projet est maintenant visible sur ton dépôt GitHub 🎉

---

## 🔁 Commandes utiles pour la suite

 Vérifier l’état du projet 

```bash
git status
```

 Voir les commits 

```bash
git log
```

 Récupérer les changements depuis GitHub 

```bash
git pull origin main
```

 Pousser de nouveaux changements 

```bash
git add .
git commit -m Nouveau commit
git push
```



