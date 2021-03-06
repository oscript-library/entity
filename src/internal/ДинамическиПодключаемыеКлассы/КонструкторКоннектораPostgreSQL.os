#Использовать sql

Функция НовыйСоединение() Экспорт
	
	Соединение = Новый Соединение();
	Возврат Соединение;

КонецФункции

Процедура Открыть(Соединение, СтрокаСоединения) Экспорт

	Соединение.ТипСУБД = Соединение.ТипыСУБД.PostgreSQL;
	Соединение.СтрокаСоединения = СтрокаСоединения;
	Соединение.Открыть();
	
КонецПроцедуры

Процедура Закрыть(Соединение) Экспорт
	Соединение.Закрыть();
КонецПроцедуры

Функция НовыйЗапрос(Соединение) Экспорт
	Запрос = Новый Запрос();
	Запрос.УстановитьСоединение(Соединение);
	Возврат Запрос;
КонецФункции

Функция ИДПоследнейДобавленнойЗаписи(Соединение, Параметры) Экспорт

	ИДПоследнейДобавленнойЗаписи = -1;

	Запрос = НовыйЗапрос(Соединение);
	Запрос.Текст = СтрШаблон("SELECT max(%1) FROM %2", Параметры.ИмяКолонки, Параметры.ИмяТаблицы);
	Рез = Запрос.Выполнить().Выгрузить();
	Если Рез.Количество() > 0 Тогда
		ИДПоследнейДобавленнойЗаписи = Рез[0]["max"];
	КонецЕсли;

	Возврат ИДПоследнейДобавленнойЗаписи;

КонецФункции

