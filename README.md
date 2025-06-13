# ML Inference Service (CatBoost)

## Описание
Этот сервис позволяет запускать инференс вашей CatBoost модели для задачи бинарной классификации. Сервис принимает на вход файл `test.csv` (как в соревновании), выполняет препроцессинг, скоринг, и сохраняет результаты в формате `sample_submission.csv`, а также выгружает топ-5 feature importances (`feature_importances.json`) и график плотности предсказаний (`density_plot.png`).

## Структура проекта
```
project_mlops/
├── input/                  # для test.csv (монтируется)
├── output/                 # для sample_submission.csv, feature_importances.json, density_plot.png (монтируется)
├── model/
│   └── catboost_model.cbm  # обученная модель CatBoost
├── scripts/
│   ├── preprocess.py       # препроцессинг test.csv
│   ├── predict.py          # скоринг, сохранение результатов
├── requirements.txt        # зависимости
├── Dockerfile              # инструкция для сборки Docker-образа
├── README.md               # этот файл
```

## Входные и выходные файлы
- **Вход:**
  - `input/test.csv` — файл для скоринга
  - `model/catboost_model.cbm` — обученная модель CatBoost
- **Выход:**
  - `output/sample_submission.csv` — файл с предсказаниями (формат как sample_submission)
  - `output/feature_importances.json` — топ-5 важных фичей (ключ — имя, значение — важность)
  - `output/density_plot.png` — график плотности предсказанных вероятностей

## Этапы пайплайна
1. **Загрузка входного файла** (`input/test.csv`)
2. **Препроцессинг** (feature engineering, обработка пропусков — см. `scripts/preprocess.py`)
3. **Скоринг** (инференс модели — см. `scripts/predict.py`)
4. **Выгрузка результатов** (`output/`)

## Инструкция по запуску через Docker

1. **Соберите Docker-образ:**
   ```sh
   docker build -t ml-inference-service .
   ```

3. **Запустите контейнер:**
   - **Windows PowerShell:**
     ```sh
     docker run --rm -v ${PWD}/input:/app/input -v ${PWD}/output:/app/output -v ${PWD}/model:/app/model ml-inference-service
     ```

4. **Проверьте результат:**
   - В папке `output/` появятся:
     - `sample_submission.csv`
     - `feature_importances.json`
     - `density_plot.png`

## Локальный запуск (без Docker)
1. Установите зависимости:
   ```sh
   pip install -r requirements.txt
   ```
2. Запустите препроцессинг:
   ```sh
   python scripts/preprocess.py
   ```
3. Запустите инференс:
   ```sh
   python scripts/predict.py
   ```
## Где взять test.csv и модель
- **test_processed.csv**: https://drive.google.com/file/d/1JojlNmhOaKfnaAezB1fxUclDFnmsogH0/view?usp=sharing
- **catboost_model.cbm**: https://drive.google.com/file/d/12ByZn00cUYWrQXP03ffjHk0L1z6EGl8C/view?usp=sharing
