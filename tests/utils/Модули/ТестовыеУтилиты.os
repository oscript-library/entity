Функция ПолучитьПеременнуюСредыИлиЗначение(ИмяПеременной, ЗначениеПоУмолчанию) Экспорт
	ПеременнаяСреды = ПолучитьПеременнуюСреды(ИмяПеременной);
	Если ПеременнаяСреды = Неопределено Тогда
		ПеременнаяСреды = ЗначениеПоУмолчанию;
	КонецЕсли;

	Возврат ПеременнаяСреды;
КонецФункции

Процедура УдалитьТаблицыВБазеДанных(Коннектор) Экспорт
	ТекстЗапроса = "DROP SCHEMA public CASCADE; CREATE SCHEMA public;";
	Коннектор.ВыполнитьЗапрос(ТекстЗапроса);
КонецПроцедуры
