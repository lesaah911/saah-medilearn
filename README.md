# \# 🏥 Saah\_MediLearn Plateforme

# 

# > Plateforme de formation médicale certifiante — 

# > Projet de cybersécurité full-stack

# 

# \---

# 

# \## 📋 Description

# 

# Simulation complète du déploiement sécurisé d'une plateforme 

# SaaS de formation médicale certifiante pour professionnels de santé.

# Projet réalisé dans le cadre d'une formation en cybersécurité 

# couvrant l'ensemble de la chaîne : infrastructure, cloud, 

# cryptographie et pentest.

# 

# \---

# 

# \## 🏗️ Architecture globale

Internet

│

▼

\[Load Balancer - HAProxy + TLS]

│

├──▶ \[Serveur Web 1 - Nginx]

└──▶ \[Serveur Web 2 - Nginx]

│

▼

\[API REST - FastAPI]

│

▼

\[MySQL Master] ──▶ \[MySQL Replica]

│

▼

\[AWS Cloud]

S3 │ RDS │ EC2 │ IAM



\---



\## 🗂️ Structure du projet

saah-medilearn/

│

├── README.md

├── database/

│   ├── sql/

│   │   └── init\_medilearn.sql     ← Schema BDD complet

│   └── diagrams/

│       └── schema\_bdd.drawio      ← Diagramme draw.io

│

├── docs/                          ← Documentation technique

├── infrastructure/                ← Config VMs, HAProxy, Nginx

├── api/                           ← Code API REST

├── cloud/                         ← Terraform AWS

├── crypto/                        ← Scripts cryptographie

├── pentest/                       ← Rapports et outils

└── malware-lab/                   ← Environnement isolé



\---



\## 🚀 Phases du projet



| Phase | Contenu | Statut |

|-------|---------|--------|

| \*\*1 - BDD\*\* | Schema MySQL, cluster Master/Replica, sécurisation | ✅ Terminé |

| \*\*2 - Infra\*\* | VMs VirtualBox, HAProxy, TLS, Load Balancing | 🔄 En cours |

| \*\*3 - Cloud\*\* | Migration AWS, API REST, Azure AD | ⏳ À venir |

| \*\*4 - Sécurité\*\* | Cryptographie, Pentest, Malware Lab | ⏳ À venir |



\---



\## 🗄️ Base de données



\### Tables principales

| Table | Description | Sécurité |

|-------|-------------|---------|

| `users` | Professionnels de santé | password Argon2, RPPS AES-256 |

| `formations` | Catalogue de formations | - |

| `modules` | Chapitres des formations | - |

| `media` | Fichiers vidéo/PDF | URLs S3 signées |

| `inscriptions` | Suivi des apprenants | - |

| `paiements` | Transactions | Tokenisation Stripe |

| `certificats` | Certifications | Signature RSA/ECDSA |

| `audit\_logs` | Journal immuable | INSERT ONLY |



\### Lancer la base de données

```bash

mysql -u root -p < database/sql/init\_medilearn.sql

```



\---



\## 🔐 Sécurité by Design



\- \*\*Mots de passe\*\* → hachage Argon2id

\- \*\*Numéros RPPS\*\* → chiffrement AES-256

\- \*\*Paiements\*\* → tokenisation (jamais de CB en clair)

\- \*\*Certificats\*\* → signature RSA/ECDSA

\- \*\*Audit logs\*\* → journal immuable INSERT ONLY

\- \*\*MySQL\*\* → principe du moindre privilège



\---



\## 🛠️ Technologies utilisées



!\[MySQL](https://img.shields.io/badge/MySQL-8.0-blue)

!\[HAProxy](https://img.shields.io/badge/HAProxy-LB-red)

!\[AWS](https://img.shields.io/badge/AWS-Cloud-orange)

!\[Python](https://img.shields.io/badge/Python-FastAPI-green)

!\[Azure](https://img.shields.io/badge/Azure-AD-blue)



\---



\## 👨‍💻 Auteur



\*\*Saah Emeric\*\* — Formation Cybersécurité 2026  

GitHub : \[@lesaah911](https://github.com/lesaah911)



\---



\## ⚠️ Avertissement



> Ce projet est réalisé dans un cadre strictement éducatif.

> Les techniques de pentest et le malware lab sont utilisés

> uniquement dans des environnements isolés et contrôlés.

