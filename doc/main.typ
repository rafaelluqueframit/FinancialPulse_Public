#import "template.typ": *

#show: lt(overwrite: false)

// LTeX: enabled=false
#show: project.with(
  title: "Plataforma de análisis predictivo de mercados basada en sentimiento financiero",
  subtitle: "FinancialPulse",
  authors: (
    "Rafael Luque Framit",
  ),
  directors: (
    "Antonio Miguel Mora García": (
      gender: "male",
      department: "Teoría de la Señal, Telemática y Comunicaciones",
      university: "Universidad de Granada",
    ),
  ),
  city: "Granada",
  grado: "Grado en Ingeniería Informática",
  abstract: "El presente Trabajo Fin de Grado tiene como objetivo el diseño y desarrollo de FinancialPulse, una plataforma web integral para el análisis financiero bursátil. La aplicación proporciona a los usuarios, tanto noveles como experimentados, herramientas para consultar datos en tiempo real de acciones, criptomonedas, índices y divisas, así como realizar análisis técnico (RSI, MACD, SMA, Bandas de Bollinger, estocástico), predecir precios mediante modelos de series temporales (Prophet), analizar el sentimiento de noticias financieras utilizando modelos de lenguaje (FinBERT y modelo en español), y simular inversiones mediante una cartera virtual. El sistema se ha implementado con Angular en el frontend, Flask en el backend y PostgreSQL como base de datos, siguiendo una arquitectura cliente-servidor y metodologías ágiles (Scrum). Los resultados demuestran la viabilidad de integrar múltiples fuentes de datos (Yahoo Finance, NewsAPI) y técnicas de inteligencia artificial en una herramienta accesible, educativa y de código abierto.",
  abstract-en: "This Final Degree Project aims to design and develop FinancialPulse, a comprehensive web platform for stock market financial analysis. The application provides users, both novice and experienced, with tools to consult real-time data for stocks, cryptocurrencies, indices and currencies, perform technical analysis (RSI, MACD, SMA, Bollinger Bands, Stochastic), forecast prices using time series models (Prophet), analyze financial news sentiment using language models (FinBERT and Spanish model), and simulate investments via a virtual portfolio. The system has been implemented with Angular on the frontend, Flask on the backend and PostgreSQL as database, following a client-server architecture and agile methodologies (Scrum). The results demonstrate the feasibility of integrating multiple data sources (Yahoo Finance, NewsAPI) and artificial intelligence techniques in an accessible, educational and open source tool.",
  keywords: "FinancialPulse, análisis bursátil, análisis de sentimiento, Prophet, cartera virtual, indicadores técnicos, finanzas, inversión, datos en tiempo real, IA",
  keywords-en: "FinancialPulse, stock market analysis, sentiment analysis, Prophet, virtual portfolio, technical indicators, finance, investment, real-time data, AI",
  acknowledgements: "A mi familia y amigos por su apoyo incondicional durante la realización de este trabajo. En concreto a mi madre por su paciencia y apoyo. A mi tutor por su orientación y cercanía. Y sobre todo a mí mismo por el esfuerzo y dedicación invertidos en este proyecto y durante toda la carrera.",
  bibliography-file: "references.bib",
)
// LTeX: enabled=true

#include "Chapters/1.introduccion.typ"
#include "Chapters/2.conceptos_preliminares.typ"
#include "Chapters/4.estado_arte.typ"
// #include "Chapters/3.definicion_problema.typ"
#include "Chapters/5.planificacion_diseno.typ"
#include "Chapters/6.herramientas_datos.typ"
#include "Chapters/7.software_desarrollado.typ"
#include "Chapters/8.evaluacion_pruebas.typ"
#include "Chapters/9.conclusiones.typ"

#bibliography("references.bib", style: "ieee")

#include "Chapters/apendices.typ"

