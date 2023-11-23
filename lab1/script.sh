#!/bin/bash

# Фамилия и имя автора
author="Чуков К.И."
# Название программы
program_name="1 л.р."
# Краткое описание
description="Скрипт предназначен для 1 лабораторной работы"

# Вывод информации о программе
echo "Автор: $author"
echo "Программа: $program_name"
echo "Описание: $description"

while true; do
  # Вывод текущего каталога
  current_directory=$(pwd)
  echo "Текущий каталог: $current_directory"

  # Проверка наличия файлов в текущем каталоге
  files_count=$(ls -A | wc -l)
  if [ $files_count -eq 0 ]; then
    echo "Ошибка: текущий каталог пуст"
    exit 1
  fi

  # Запрос имени файла
  echo "Введите имя файла:"
  read filename

  # Проверка наличия файла с заданным именем
  if [ ! -f "$filename" ]; then
    echo "Ошибка: файл с именем $filename не найден"
    continue
  fi

  # Запрос даты
  echo "Введите дату (в формате ГГГГ-ММ-ДД):"
  read date

  # Проверка корректности введенной даты
  if ! date -d "$date" >/dev/null 2>&1; then
    echo "Ошибка: некорректная дата"
    continue
  fi

  # Проверка доступа к файлу после указанной даты
  if [ "$(find "$filename" -newermt "$date" 2>/dev/null)" ]; then
    echo "Доступ к файлу $filename осуществлялся после указанной даты"
  else
    echo "Доступ к файлу $filename не осуществлялся после указанной даты"
    echo "Завершение работы скрипта (код: 120)"
    exit 120
    
  fi

  # Запрос продолжения работы
  echo "Хотите продолжить (y/n)? "
  read choice
  case $choice in
    [Yy]* ) continue;;
    [Nn]* ) exit;;
    * ) echo "Ошибка: некорректный ввод"; exit 1;;
  esac
done
