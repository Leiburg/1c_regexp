
// SPDX-License-Identifier: MIT

#Область СлужебныйПрограммныйИнтерфейс
// Возвращает множество метасимволов
// 
// Возвращаемое значение:
//  ФиксированноеСоответствие - ключи содержат метасимволы
//
Функция Метасимволы() Экспорт
	фРезультат = Новый Соответствие;
	Для Каждого МетаСимвол Из СтрРазделить("(,),[,],|,*,+,?", ",") Цикл
		фРезультат.Вставить(МетаСимвол, Истина);
	КонецЦикла;
	
	Возврат Новый ФиксированноеСоответствие(фРезультат);
КонецФункции

// Возвращает множество символов экранирования
// 
// Возвращаемое значение:
//  ФиксированноеСоответствие - значения по символам экранирования
//
Функция ЭкранированияСимволов() Экспорт
	фРезультат = Новый Соответствие;
	
	Для Каждого КЗ Из РегВырПовтИсп.Метасимволы() Цикл
		фРезультат.Вставить(КЗ.Ключ, КЗ.Ключ);
	КонецЦикла;
	
	фРезультат.Вставить("\", "\");
	фРезультат.Вставить(".", ".");
	фРезультат.Вставить("t", Символ(9)); // Символы.Таб
	фРезультат.Вставить("n", Символ(10)); // Символы.ПС
	фРезультат.Вставить("r", Символ(13)); // Символы.ВК
	фРезультат.Вставить("f", Символ(12)); // Символы.ПФ
	фРезультат.Вставить("a", Символ(7));
	фРезультат.Вставить("e", Символ(27)); // backspace
	
	Возврат Новый ФиксированноеСоответствие(фРезультат);
КонецФункции

// Возвращает множество символов экранирования в классах символов
// 
// Возвращаемое значение:
//  ФиксированноеСоответствие - значения по символам экранирования
//
Функция ЭкранированияСимволовВКлассе() Экспорт
	фРезультат = Новый Соответствие(РегВырПовтИсп.ЭкранированияСимволов());
	фРезультат.Удалить(".");
	
	Для Каждого КЗ Из РегВырПовтИсп.Метасимволы() Цикл
		фРезультат.Удалить(КЗ.Ключ);
	КонецЦикла;
	
	фРезультат.Вставить("-", "-");
	фРезультат.Вставить("[", "[");
	фРезультат.Вставить("]", "]");
	
	Возврат Новый ФиксированноеСоответствие(фРезультат);
КонецФункции

// Возвращает множество предопределённых классов символов
// 
// Возвращаемое значение:
//  ФиксированноеСоответствие - классы символов по символам экранирования
//
Функция ПредопределенныеКлассыСимволов() Экспорт
	фРезультат = Новый Соответствие;
	
	фРезультат.Вставить("d", ТокеныКлассаСимволовЧисла()); // [0-9]
	фРезультат.Вставить("D", ТокеныКлассаСимволовЧисла(Истина)); // [^0-9]
	фРезультат.Вставить("h", ТокеныКлассаСимволовГоризонтальныеОтступы()); // [ \t\xA0\u1680\u180e\u2000-\u200a\u202f\u205f\u3000]
	фРезультат.Вставить("H", ТокеныКлассаСимволовГоризонтальныеОтступы(Истина)); // [^\h]
	фРезультат.Вставить("s", ТокеныКлассаПробельныхСимволов()); // [ \t\n\x0B\f\r]
	фРезультат.Вставить("S", ТокеныКлассаПробельныхСимволов(Истина)); // [^\s]
	фРезультат.Вставить("v", ТокеныКлассаСимволовВертикальныеОтступы()); // [\n\x0B\f\r\x85\u2028\u2029]
	фРезультат.Вставить("V", ТокеныКлассаСимволовВертикальныеОтступы(Истина)); // [^\v]
	фРезультат.Вставить("w", ТокеныКлассаСимволовСлов()); // [a-zA-Z_0-9]
	фРезультат.Вставить("W", ТокеныКлассаСимволовСлов(Истина)); // [^\w]
	
	Возврат Новый ФиксированноеСоответствие(фРезультат);
КонецФункции

// Возвращает имя типа токена метасимвола
// 
// Возвращаемое значение:
//  Строка - имя типа
//
Функция ТипТокенаМетасимвол() Экспорт
	Возврат "Мета";
КонецФункции

// Возвращает имя типа токена класса символов
// 
// Возвращаемое значение:
//  Строка - имя типа
//
Функция ТипТокенаКлассСимволов() Экспорт
	Возврат "Класс";
КонецФункции

// Возвращает соответствие цифр Hex и Dec
// 
// Возвращаемое значение:
//  ФиксированноеСоответствие - соответствие цифр Hex и Dec
//
Функция ЗначенияЦифрHexВDec() Экспорт
	фРезультат = Новый Соответствие;
	фРезультат.Вставить("0", 0);
	фРезультат.Вставить("1", 1);
	фРезультат.Вставить("2", 2);
	фРезультат.Вставить("3", 3);
	фРезультат.Вставить("4", 4);
	фРезультат.Вставить("5", 5);
	фРезультат.Вставить("6", 6);
	фРезультат.Вставить("7", 7);
	фРезультат.Вставить("8", 8);
	фРезультат.Вставить("9", 9);
	фРезультат.Вставить("A", 10);
	фРезультат.Вставить("B", 11);
	фРезультат.Вставить("C", 12);
	фРезультат.Вставить("D", 13);
	фРезультат.Вставить("E", 14);
	фРезультат.Вставить("F", 15);
	
	Возврат Новый ФиксированноеСоответствие(фРезультат);
КонецФункции
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
Функция ТокеныНовогоКлассаСимволов(Знач Токен)
	фРезультат = Новый Массив;
	фРезультат.Добавить(ТокенМетаСимвола("["));
	фРезультат.Добавить(Токен);
	фРезультат.Добавить(ТокенМетаСимвола("]"));
	
	Возврат фРезультат;
КонецФункции

Функция ТокеныКлассаСимволовСлов(Знач Отрицание = Ложь)
	Диапазоны = Новый Массив;
	ДобавитьДиапазон(Диапазоны, "a", "z"); // a-z
	ДобавитьДиапазон(Диапазоны, "A", "Z"); // A-Z
	ДобавитьДиапазон(Диапазоны, "0", "9"); // 0-9
	
	Токен = НовыйТокен(РегВырПовтИсп.ТипТокенаКлассСимволов(), НовыеДанныеТокенаКлассаСимволов(Отрицание));
	ДобавитьВТокенКлассаСимволов(Токен, "_");
	ДобавитьВТокенКлассаСимволов(Токен, "Диапазоны", Диапазоны);
	
	Возврат ТокеныНовогоКлассаСимволов(Токен);
КонецФункции

Функция ТокеныКлассаПробельныхСимволов(Знач Отрицание = Ложь)
	Токен = НовыйТокен(РегВырПовтИсп.ТипТокенаКлассСимволов(), НовыеДанныеТокенаКлассаСимволов(Отрицание));
	ДобавитьВТокенКлассаСимволов(Токен, " ");
	ДобавитьВТокенКлассаСимволов(Токен, Символ(9)); // \t
	ДобавитьВТокенКлассаСимволов(Токен, Символ(10)); // \n
	ДобавитьВТокенКлассаСимволов(Токен, Символ(11)); // \x0B
	ДобавитьВТокенКлассаСимволов(Токен, Символ(12)); // \f
	ДобавитьВТокенКлассаСимволов(Токен, Символ(13)); // \r
	
	Возврат ТокеныНовогоКлассаСимволов(Токен);
КонецФункции

Функция ТокеныКлассаСимволовГоризонтальныеОтступы(Знач Отрицание = Ложь)
	Диапазоны = Новый Массив;
	ДобавитьДиапазон(Диапазоны, Символ(8192), Символ(8202)); // \u2000-\u200a
	
	Токен = НовыйТокен(РегВырПовтИсп.ТипТокенаКлассСимволов(), НовыеДанныеТокенаКлассаСимволов(Отрицание));
	ДобавитьВТокенКлассаСимволов(Токен, " ");
	ДобавитьВТокенКлассаСимволов(Токен, Символ(9)); // \t
	ДобавитьВТокенКлассаСимволов(Токен, Символ(160)); // \xA0
	ДобавитьВТокенКлассаСимволов(Токен, Символ(5760)); // \u1680
	ДобавитьВТокенКлассаСимволов(Токен, Символ(6158)); // \u180e
	ДобавитьВТокенКлассаСимволов(Токен, Символ(8239)); // \u202f
	ДобавитьВТокенКлассаСимволов(Токен, Символ(8287)); // \u205f
	ДобавитьВТокенКлассаСимволов(Токен, Символ(12288)); // \u3000
	ДобавитьВТокенКлассаСимволов(Токен, "Диапазоны", Диапазоны);
	
	Возврат ТокеныНовогоКлассаСимволов(Токен);
КонецФункции

Функция ТокеныКлассаСимволовВертикальныеОтступы(Знач Отрицание = Ложь)
	Токен = НовыйТокен(РегВырПовтИсп.ТипТокенаКлассСимволов(), НовыеДанныеТокенаКлассаСимволов(Отрицание));
	ДобавитьВТокенКлассаСимволов(Токен, Символ(10)); // \n
	ДобавитьВТокенКлассаСимволов(Токен, Символ(11)); // \x0B
	ДобавитьВТокенКлассаСимволов(Токен, Символ(12)); // \f
	ДобавитьВТокенКлассаСимволов(Токен, Символ(13)); // \r
	ДобавитьВТокенКлассаСимволов(Токен, Символ(133)); // \x85
	ДобавитьВТокенКлассаСимволов(Токен, Символ(8232)); // \u2028
	ДобавитьВТокенКлассаСимволов(Токен, Символ(8233)); // \u2029
	
	Возврат ТокеныНовогоКлассаСимволов(Токен);
КонецФункции

Функция ТокеныКлассаСимволовЧисла(Знач Отрицание = Ложь)
	Диапазоны = Новый Массив;
	ДобавитьДиапазон(Диапазоны, "0", "9");
	
	Токен = НовыйТокен(РегВырПовтИсп.ТипТокенаКлассСимволов(), НовыеДанныеТокенаКлассаСимволов(Отрицание));
	ДобавитьВТокенКлассаСимволов(Токен, "Диапазоны", Диапазоны);
	
	Возврат ТокеныНовогоКлассаСимволов(Токен);
КонецФункции

Функция ТокенМетаСимвола(Знач Значение)
	Возврат Новый Структура("Тип, Значение", РегуляркаПовтИсп.ТипТокенаМетасимвол(), Значение);
КонецФункции

Функция НовыйТокен(Знач Тип, Знач Данные = Неопределено)
	Возврат Новый Структура("Тип, Данные", Тип, Данные);
КонецФункции

Функция НовыеДанныеТокенаКлассаСимволов(Знач Отрицание = Ложь)
	Возврат Новый Структура("Отрицание, Класс", Отрицание, Новый Соответствие);
КонецФункции

Процедура ДобавитьДиапазон(Диапазоны, Знач ЛевыйСимвол, Знач ПравыйСимвол)
	Диапазоны.Добавить(Новый Структура("Начало, Окончание", КодСимвола(ЛевыйСимвол), КодСимвола(ПравыйСимвол)));
КонецПроцедуры

Процедура ДобавитьВТокенКлассаСимволов(Токен, Знач Ключ, Знач Значение = Истина)
	Токен.Данные.Класс.Вставить(Ключ, Значение);
КонецПроцедуры
#КонецОбласти
