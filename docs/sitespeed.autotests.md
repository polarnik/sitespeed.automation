---
marp: true
title: Автотесты производительности Web
description: Автотесты производительности Web. Allure, JUnit, Java TestContainer, SiteSpeed.io
theme: rt
template: bespoke
paginate: false
_paginate: false

---

<!-- _class: lead
-->

# Автотесты 

## производительности __Web__

### 14 сентябя, Online, RT

<!--
_footer: `Image by Vlad Gerasimov on https://vlad.studio/`
 -->

---

- Miro, почему Miro это контентный проект, почему тут важна клиенсткая производительность
- Инструменты замера клиентской производительности и как sitespeed.io объединил их
- Просто запускаем sitespeed.io для одной страницы
- Делаем тест на то, что запуск прошел успешно
- Что можно проверить, кроме факта успешности?
- Добавляем отправку метрик в InfluxDB или VictoriaMetrics
- Добавляем Allert-ы по метрикам
- Добавляем Assert-ы по метрикам
- Какие еще есть варианты автоматизации?

---

# Контентные проекты

- Miro
- Поисковые системы
- Online-телевидение
- Социальные сети
- Словари и энциклопедии
- Новостные порталы
- Интернет-магазины
- Сайты погоды
- Книги и журналы
- Доски объявлений
- ...

---

# Инструменты замера клиентской производительности

Для накопления метрик пользователей:

- Grafana Faro
- Sentry
- ...

Для тестирования:

- __Web Developer Tools__ (браузера Google Chrome)
- __PageSpeed Insights__, 🔗 https://pagespeed.web.dev/
- __LightHouse__, 🔗 https://github.com/GoogleChrome/lighthouse
- __Pagespeed Compare__, 🔗 https://pagespeed.compare/
- __WebPageTest__, 🔗 https://webpagetest.org/
- __Treo__, 🔗 https://treo.sh

---

# SiteSpeed.io объединил __инструменты__

- Основные метрики __WebVitals__

- Метрики __LightHouse__
- Метрики __WebPageTest__
- Возможность использовать Proxy
- Возможность сравнить метрики

---

# Простой запуск sitespee.io

---

# 


---
