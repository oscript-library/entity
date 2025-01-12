#Использовать "../src"
#Использовать 1testrunner
#Использовать fs

Функция ПрогнатьТесты()
	
	Тестер = Новый Тестер;
	Тестер.УстановитьФорматЛогФайла(Тестер.ФорматыЛогФайла().GenericExec);

	ПутьКТестам = ОбъединитьПути(ТекущийСценарий().Каталог, "..", "tests");
	ПутьКОтчетуJUnit = ОбъединитьПути(ТекущийСценарий().Каталог, "..", "out");

	ФС.ОбеспечитьПустойКаталог(ПутьКОтчетуJUnit);

	КаталогТестов = Новый Файл(ПутьКТестам);
	Если Не КаталогТестов.Существует() Тогда
		Сообщить(СтрШаблон("Не найден каталог тестов %1", ПутьКТестам));
		Возврат Истина;
	КонецЕсли;

	РезультатТестирования = Тестер.ТестироватьКаталог(
		КаталогТестов,
		Новый Файл(ПутьКОтчетуJUnit)
	);

	Успешно = РезультатТестирования = 0;
	
	Возврат Успешно;
КонецФункции // ПрогнатьТесты()

Попытка
	ТестыПрошли = ПрогнатьТесты();

Исключение
	ТестыПрошли = Ложь;
	Сообщить(СтрШаблон("Тесты через 1testrunner выполнены неудачно
	|%1", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке())));
КонецПопытки;

Если Не ТестыПрошли Тогда
	ВызватьИсключение "Тестирование завершилось неудачно!";
Иначе
	Сообщить(СтрШаблон("Результат прогона тестов <%1>
	|", ТестыПрошли));
КонецЕсли;

