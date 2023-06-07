
// SPDX-License-Identifier: MIT

#Область ПрограммныйИнтерфейс
Функция ПроцессорРаспознования(Знач Шаблон) Экспорт
	Токены = ТокеныШаблона(Шаблон);
	Орграф = НовыйОрграф(Токены.Количество() + 1);
	Стек = НовыйСтек();
	ИндексыОператоровИЛИ = Новый Массив;
	М = Токены.ВГраница();
	
	МетаСимволы = Новый Соответствие;
	Для Каждого МетаСимвол Из СтрРазделить("(,),[,],*,+,?", ",") Цикл
		МетаСимволы.Вставить(МетаСимвол, Истина);
	КонецЦикла;
	
	Для я = 0 По М Цикл
		ПозицияЛевойСкобки = я;
		Токен = Токены[я];
		Если Токен = "(" ИЛИ Токен = "|" Тогда
            ДобавитьВСтек(Стек, я);
		ИначеЕсли Токен = ")" Тогда
			ИндексыОператоровИЛИ.Очистить();
			НачальныйСимвол = "";
			Пока НачальныйСимвол <> "(" Цикл
				Если СтекПустой(Стек) Тогда
					ВызватьИсключение "Ошибка разбора шаблона";
				КонецЕсли;
				
	            ПозицияОператора = ИзъятьИзСтека(Стек);
				НачальныйСимвол = Токены[ПозицияОператора];
				Если НачальныйСимвол = "|" Тогда
					ИндексыОператоровИЛИ.Добавить(ПозицияОператора);
	            ИначеЕсли НачальныйСимвол = "(" Тогда
	                ПозицияЛевойСкобки = ПозицияОператора;
					Для Каждого Индекс Из ИндексыОператоровИЛИ Цикл
						ДобавитьНаправлениеВОрграф(Орграф, ПозицияЛевойСкобки, Индекс+1);
						ДобавитьНаправлениеВОрграф(Орграф, Индекс, я);
					КонецЦикла;
				КонецЕсли;
			КонецЦикла;
		ИначеЕсли Токен = "]" Тогда
			ПозицияЛевойСкобки = я - 2;
        КонецЕсли;
		Если я < М Тогда
			СледующийТокен = Токены[я+1];;
			Если СледующийТокен = "*" Тогда
				ДобавитьНаправлениеВОрграф(Орграф, ПозицияЛевойСкобки, я+1);
				ДобавитьНаправлениеВОрграф(Орграф, я+1, ПозицияЛевойСкобки);
			ИначеЕсли СледующийТокен = "+" Тогда
				ДобавитьНаправлениеВОрграф(Орграф, я+1, ПозицияЛевойСкобки);
			ИначеЕсли СледующийТокен = "?" Тогда
				ДобавитьНаправлениеВОрграф(Орграф, ПозицияЛевойСкобки, я+2);
			КонецЕсли;
        КонецЕсли;
        Если МетаСимволы.Получить(Токен) <> Неопределено Тогда
            ДобавитьНаправлениеВОрграф(Орграф, я, я+1);
		КонецЕсли;
    КонецЦикла;
	
	ТипСтрока = Тип("Строка");
	Для я = 0 По Токены.ВГраница() Цикл
		Токен = Токены[я];
		Если ТипЗнч(Токен) = ТипСтрока И МетаСимволы.Получить(Токен) <> Неопределено Тогда
			Токены[я] = ТокенМетаСимвола(Токен);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Новый Структура("Шаблон, Орграф", Токены, Орграф);
КонецФункции

Функция Распознано(Знач Процессор, Знач Текст) Экспорт
	ТипСоответствие = Тип("Соответствие");
	ТипСтрока = Тип("Строка");
	Вершины = НовыйМешок();
	ОбъектПВГ = НовыйНаправленныйПоискВГлубину(Процессор.Орграф, 0);
	М = Процессор.Шаблон.Количество();
	
	Для Вершина = 0 По КоличествоВершинОрграфа(Процессор.Орграф) - 1 Цикл
		Если НайденоПоискомВГлубину(ОбъектПВГ, Вершина) Тогда
			ДобавитьВМешок(Вершины, Вершина);
		КонецЕсли;
	КонецЦикла;

	Для я = 1 По СтрДлина(Текст) Цикл
		Символ = Сред(Текст, я, 1);
		Совпадения = НовыйМешок();
		Для Каждого Вершина Из ЭлементыМешка(Вершины) Цикл
			Если Вершина < М Тогда
				Токен = Процессор.Шаблон[Вершина];
				ТипТокена = ТипЗнч(Токен);
				Если ТипТокена = ТипСоответствие Тогда
					Если СимволПринадлежитКлассу(Символ, Токен) Тогда
						ДобавитьВМешок(Совпадения, Вершина+1);
					КонецЕсли;
				ИначеЕсли ТипТокена = ТипСтрока И (Токен = "." ИЛИ Токен = Символ) Тогда
					ДобавитьВМешок(Совпадения, Вершина+1);
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
		
		Вершины = НовыйМешок();
		ОбъектПВГ = НовыйНаправленныйПоискВГлубинуПоВершинам(Процессор.Орграф, Совпадения);
		Для Вершина = 0 По КоличествоВершинОрграфа(Процессор.Орграф) - 1 Цикл
			Если НайденоПоискомВГлубину(ОбъектПВГ, Вершина) Тогда
				ДобавитьВМешок(Вершины, Вершина);
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	Для Каждого Вершина Из ЭлементыМешка(Вершины) Цикл
		Если Вершина = М Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
КонецФункции
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
#Область КОНСТРУКТОРЫ
Функция НовыйСтек()
	Возврат Новый Массив;
КонецФункции

Функция НовыйМешок()
	Возврат Новый Структура("Первая, Хранилище", Неопределено, Новый Соответствие);
КонецФункции

Функция НоваяНода(Знач Значение)
	Возврат Новый Структура("Ссылка, Следующая, Значение", 0, Неопределено, Значение);
КонецФункции

Функция НовыйОрграф(Знач Мощность)
	фРезультат = Новый Массив;
	Для я = 1 По Мощность Цикл
		фРезультат.Добавить(НовыйМешок());
	КонецЦикла;
	
	Возврат фРезультат;
КонецФункции

Функция НовыйНаправленныйПоискВГлубину(Знач Орграф, Знач НомерВершины)
	фРезультат = Новый Массив;
	Для _ = 1 По КоличествоВершинОрграфа(Орграф) Цикл
		фРезультат.Добавить(Ложь);
	КонецЦикла;
	
	ПоискВГлубину(фРезультат, Орграф, НомерВершины);
	
	Возврат фРезультат;
КонецФункции

Функция НовыйНаправленныйПоискВГлубинуПоВершинам(Знач Орграф, Знач Источники)
	фРезультат = Новый Массив;
	Для _ = 1 По КоличествоВершинОрграфа(Орграф) Цикл
		фРезультат.Добавить(Ложь);
	КонецЦикла;
	
	Для Каждого Источник Из ЭлементыМешка(Источники) Цикл
		Если НЕ фРезультат.Получить(Источник) Тогда
			ПоискВГлубину(фРезультат, Орграф, Источник);
		КонецЕсли;
	КонецЦикла;
	
	Возврат фРезультат;
КонецФункции

#Область Стек
Процедура ДобавитьВСтек(Стек, Знач Значение)
	Стек.Добавить(Значение);
КонецПроцедуры

Функция ИзъятьИзСтека(Стек)
	Перем фРезультат;
	Если СтекПустой(Стек) Тогда
		Возврат фРезультат;
	КонецЕсли;
	фРезультат = Стек.Получить(Стек.ВГраница());
	Стек.Удалить(Стек.ВГраница());
	Возврат фРезультат;
КонецФункции

Функция ВзятьИзСтека(Знач Стек)
	Перем фРезультат;
	Если СтекПустой(Стек) Тогда
		Возврат фРезультат;
	КонецЕсли;
	
	Возврат Стек.Получить(Стек.ВГраница());
КонецФункции

Функция ЭлементыСтека(Знач Стек)
	фРезультат = Новый Массив;
	
	Если СтекПустой(Стек) Тогда
		Возврат фРезультат;
	КонецЕсли;
	
	я = Стек.ВГраница();
	Пока я >= 0 Цикл
		фРезультат.Добавить(Стек[я]);
		я = я - 1;
	КонецЦикла;
	
	Возврат фРезультат;
КонецФункции

Функция СтекПустой(Знач Стек)
	Возврат Стек.Количество() = 0;
КонецФункции
#КонецОбласти

#Область Мешок
Процедура ДобавитьВМешок(Мешок, Знач Значение)
	НоваяПервая = НоваяНода(Значение);
	ТекущаяПервая = Мешок.Первая;
	Если ТекущаяПервая <> Неопределено Тогда
		ТекущаяПервая = ТекущаяПервая.Ссылка;
		НоваяПервая.Ссылка = ТекущаяПервая + 1;
	КонецЕсли;
	НоваяПервая.Следующая = ТекущаяПервая;
	Мешок.Первая = НоваяПервая;
	Мешок.Хранилище.Вставить(НоваяПервая.Ссылка, НоваяПервая);
КонецПроцедуры

Функция РазмерМешка(Знач Мешок)
	Возврат Мешок.Хранилище.Количество();
КонецФункции

Функция МешокПуст(Знач Мешок)
	Возврат Мешок.Хранилище.Количество() = 0;
КонецФункции

Функция ЭлементыМешка(Знач Мешок)
	фРезультат = Новый Массив;
	
	Текущая = Мешок.Первая;
	Пока Текущая <> Неопределено Цикл
		фРезультат.Добавить(Текущая.Значение);
		Текущая = Мешок.Хранилище.Получить(Текущая.Следующая);
	КонецЦикла;
	
	Возврат фРезультат;
КонецФункции
#КонецОбласти

#Область ОриентированныйГраф
Функция КоличествоВершинОрграфа(Знач Орграф)
	Возврат Орграф.Количество();
КонецФункции

Функция КоличествоНаправленийОрграфа(Знач Орграф)
	фРезультат = 0;
	
	Для Каждого Направления Из Орграф Цикл
		фРезультат = фРезультат + РазмерМешка(Направления);
	КонецЦикла;
	
	Возврат фРезультат;
КонецФункции

Функция ДобавитьНаправлениеВОрграф(Орграф, Знач НомерВершиныОтправления, Знач НомерВершиныНазначения)
	Направления = Орграф.Получить(НомерВершиныОтправления);
	ДобавитьВМешок(Направления, НомерВершиныНазначения);
КонецФункции

Функция РеверсОрграфа(Знач Орграф)
	фРезультат = НовыйОрграф(КоличествоВершинОрграфа(Орграф));
	Для я = 0 По КоличествоВершинОрграфа(Орграф)-1 Цикл
		Для Каждого Направление Из ЭлементыМешка(Орграф.Получить(я)) Цикл
			ДобавитьНаправлениеВОрграф(фРезультат, я, Направление);
		КонецЦикла;
	КонецЦикла;
КонецФункции
#КонецОбласти

#Область ПоискВГлубину
Процедура ПоискВГлубину(Знач ОбъектПВГ, Знач Орграф, Знач НомерВершины)
	ОбъектПВГ.Установить(НомерВершины, Истина);
	Для Каждого Направление Из ЭлементыМешка(Орграф.Получить(НомерВершины)) Цикл
		Если НЕ ОбъектПВГ.Получить(Направление) Тогда
			ПоискВГлубину(ОбъектПВГ, Орграф, Направление);
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

Функция НайденоПоискомВГлубину(Знач ОбъектПВГ, Знач НомерВершины)
	Возврат ОбъектПВГ.Получить(НомерВершины);
КонецФункции
#КонецОбласти

Функция ТокеныШаблона(Знач Шаблон)
	фРезультат = Новый Массив;
	
	Для я = 1 По СтрДлина(Шаблон) Цикл
		Символ = Сред(Шаблон, я, 1);
		Если Символ = "[" Тогда
			ОбработатьКлассСимволов(фРезультат, я, Шаблон); 
		ИначеЕсли Символ = "{" Тогда
			ОбработатьКвантификатор(фРезультат, я, Шаблон);
		Иначе
			фРезультат.Добавить(Символ);
		КонецЕсли;
	КонецЦикла;
	
	Возврат фРезультат;
КонецФункции

Процедура ОбработатьКлассСимволов(Токены, Индекс, Знач Шаблон)
	Токены.Добавить("[");
	
	КлассСимволов = Новый Соответствие;
	СимволыКласса = Новый Массив;
	ПозицииСимволов = Новый Массив;
	
	Индекс = Индекс + 1;
	СледующийСимвол = Сред(Шаблон, Индекс, 1);
	Пока СледующийСимвол <> "]" Цикл
		СимволыКласса.Добавить(СледующийСимвол);
		Индекс = Индекс + 1;
		СледующийСимвол = Сред(Шаблон, Индекс, 1);
	КонецЦикла;
	
	М = СимволыКласса.ВГраница();
	Диапазоны = Новый Массив;
	
	Для я = 0 По М Цикл
		Если СимволыКласса[я] = "-" И 0 < я И я < М Тогда
			ДобавитьДиапазон(Диапазоны, СимволыКласса[я-1], СимволыКласса[я+1]);
			ПозицииСимволов.Удалить(ПозицииСимволов.ВГраница());
			я = я + 1;
			Продолжить;
		КонецЕсли;
		
	    ПозицииСимволов.Добавить(я);
	КонецЦикла;
	
	Для Каждого я Из ПозицииСимволов Цикл
		КлассСимволов.Вставить(СимволыКласса[я], Истина);
	КонецЦикла;
	Если Диапазоны.Количество() > 0 Тогда
		КлассСимволов.Вставить("Диапазоны", Диапазоны);
	КонецЕсли;
	
	Токены.Добавить(КлассСимволов);
	Токены.Добавить("]");
КонецПроцедуры

Процедура ДобавитьДиапазон(Диапазоны, Знач ЛевыйСимвол, Знач ПравыйСимвол)
	Диапазоны.Добавить(Новый Структура("Начало, Окончание", КодСимвола(ЛевыйСимвол), КодСимвола(ПравыйСимвол)));
КонецПроцедуры

Функция ТокенМетаСимвола(Знач Значение)
	Возврат Новый Структура("Тип, Значение", "Мета", Значение);
КонецФункции

Функция СимволПринадлежитКлассу(Знач Символ, Знач Токен)
	Если Токен.Получить(Символ) <> Неопределено Тогда
		Возврат Истина;
	КонецЕсли;
	
	Диапазоны = Токен.Получить("Диапазоны");
	Если Диапазоны = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Код = КодСимвола(Символ);
	Для Каждого Диапазон Из Диапазоны Цикл
		Если Диапазон.Начало <= Код И Код <= Диапазон.Окончание Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
КонецФункции

Процедура ОбработатьКвантификатор(Токены, Индекс, Знач Шаблон)
	СимволыКвантификатора = Новый Массив;
	Индекс = Индекс + 1;
	СледующийСимвол = Сред(Шаблон, Индекс, 1);
	Пока СледующийСимвол <> "}" Цикл
		СимволыКвантификатора.Добавить(СледующийСимвол);
		Индекс = Индекс + 1;
		СледующийСимвол = Сред(Шаблон, Индекс, 1);
	КонецЦикла;
	
	ЧастиКвантификатора = СтрРазделить(СтрСоединить(СимволыКвантификатора), ",");
	Если ЧастиКвантификатора.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ДополнительныеТокены = Новый Массив;
	ТипЧисло = Новый ОписаниеТипов("Число");
	МинимумПовторений = ТипЧисло.ПривестиЗначение(СокрЛП(ЧастиКвантификатора[0]));
	МаксимумПовторений = МинимумПовторений;
	Если ЧастиКвантификатора.Количество() > 1 Тогда
		МаксимумПовторений = ТипЧисло.ПривестиЗначение(СокрЛП(ЧастиКвантификатора[1]));
	КонецЕсли;
	Если МаксимумПовторений > 0 И МаксимумПовторений < МинимумПовторений Тогда
		ВызватьИсключение "Ошибка разбора шаблона";
	ИначеЕсли МинимумПовторений = 0 Тогда
		Если МаксимумПовторений < 2 Тогда
			Токены.Добавить(?(МаксимумПовторений = 0, "*", "?"));
			Возврат;
		КонецЕсли;
		ДополнительныеТокены.Добавить("?");
		МаксимумПовторений = МаксимумПовторений - 1;
	ИначеЕсли МинимумПовторений = 1 И МаксимумПовторений = 0 Тогда
		Токены.Добавить("+");
		Возврат;
	КонецЕсли;
	
	ТокеныПовторения = Новый Массив;
	ПредыдущийТокен = Токены[Токены.ВГраница()];
	Если ПредыдущийТокен = "]" Тогда
		ТокеныПовторения.Добавить("[");
		ТокеныПовторения.Добавить(Токены[Токены.ВГраница()-1]);
		ТокеныПовторения.Добавить("]");
	ИначеЕсли ПредыдущийТокен = ")" Тогда
		Стек = НовыйСтек();
		я = Токены.ВГраница();
		Пока я >= 0 Цикл
			Токен = Токены[я];
			ДобавитьВСтек(Стек, Токен);
			Если Токен = "(" Тогда
				Прервать;
			КонецЕсли;
			я = я - 1;
		КонецЦикла;
		ТокеныПовторения = ЭлементыСтека(Стек);
	Иначе
		ТокеныПовторения.Добавить(ПредыдущийТокен);
	КонецЕсли;
	
	Для Каждого Токен Из ДополнительныеТокены Цикл
		Токены.Добавить(Токен);
	КонецЦикла;
	
	Для я = 1 По МинимумПовторений - 1 Цикл
		Для Каждого Токен Из ТокеныПовторения Цикл
			Токены.Добавить(Токен);
		КонецЦикла;
	КонецЦикла;
	Если МаксимумПовторений = 0 Тогда
		Токены.Добавить("+");
		Возврат;
	КонецЕсли;
	Для я = 1 По МаксимумПовторений - МинимумПовторений Цикл
		Для Каждого Токен Из ТокеныПовторения Цикл
			Токены.Добавить(Токен);
		КонецЦикла;
		Токены.Добавить("?");
	КонецЦикла;
КонецПроцедуры
#КонецОбласти
