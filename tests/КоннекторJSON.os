#Использовать fs
#Использовать ".."

Перем Коннектор;
Перем СтрокаСоединения;

Процедура ПередЗапускомТеста() Экспорт
	ПодключитьСценарий(ОбъединитьПути(ТекущийКаталог(), "tests", "fixtures", "СущностьСоВсемиТипамиКолонок.os"), "СущностьСоВсемиТипамиКолонок");
	ПодключитьСценарий(ОбъединитьПути(ТекущийКаталог(), "tests", "fixtures", "АвтоинкрементныйКлючБезКолонок.os"), "АвтоинкрементныйКлючБезКолонок");
	
	СтрокаСоединения = ОбъединитьПути(ТекущийКаталог(), "tests", "jsontestdata");
	СоздатьКаталог(СтрокаСоединения);
	
	Коннектор = Новый КоннекторJSON();
	Коннектор.Открыть(СтрокаСоединения, Новый Массив);
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	Коннектор.Закрыть();
	УдалитьФайлы(СтрокаСоединения);
КонецПроцедуры

&Тест
Процедура КоннекторJSONРеализуетИнтерфейсКоннектора() Экспорт
	ИнтерфейсОбъекта = Новый ИнтерфейсОбъекта();
	ИнтерфейсОбъекта.ИзОбъекта(Тип("АбстрактныйКоннектор"));
	
	РефлекторОбъекта = Новый РефлекторОбъекта(Тип("КоннекторJSON"));
	РефлекторОбъекта.РеализуетИнтерфейс(ИнтерфейсОбъекта, Истина);
КонецПроцедуры

&Тест
Процедура НайтиСтрокиВТаблице() Экспорт
	МодельДанных = Новый МодельДанных();
	ОбъектМодели = МодельДанных.СоздатьОбъектМодели(Тип("СущностьСоВсемиТипамиКолонок"));
	Коннектор.ИнициализироватьТаблицу(ОбъектМодели);
	
	ЗависимаяСущность = Новый СущностьСоВсемиТипамиКолонок;
	ЗависимаяСущность.Целое = 2;
	
	Сущность = Новый СущностьСоВсемиТипамиКолонок;
	Сущность.Целое = 1;
	Сущность.Дробное = 1.2;
	Сущность.БулевоИстина = Истина;
	Сущность.БулевоЛожь = Ложь;
	Сущность.Строка = "Строка";
	Сущность.Дата = Дата(2018, 1, 1);
	Сущность.Время = Дата(1, 1, 1, 10, 53, 20);
	Сущность.ДатаВремя = Дата(2018, 1, 1, 10, 53, 20);
	Сущность.Ссылка = ЗависимаяСущность;
	Сущность.ДвоичныеДанные = ПолучитьДвоичныеДанныеИзСтроки("ДвоичныеДанные");
	
	Коннектор.Сохранить(ОбъектМодели, ЗависимаяСущность);
	Коннектор.Сохранить(ОбъектМодели, Сущность);
	
	Отбор = Новый Массив;
	Отбор.Добавить(Новый ЭлементОтбора("Целое", ВидСравнения.Равно, Сущность.Целое));
	НайденныеСтроки = Коннектор.НайтиСтрокиВТаблице(ОбъектМодели, Отбор);
	Ожидаем.Что(НайденныеСтроки, "Сущность сохранилась").ИмеетДлину(1);

	ЗначенияКолонок = НайденныеСтроки[0];

	Ожидаем.Что(ЗначенияКолонок.Получить("Целое"), "ЗначенияКолонок.Целое получено корректно").Равно(Сущность.Целое);
	Ожидаем.Что(ЗначенияКолонок.Получить("Дробное"), "ЗначенияКолонок.Дробное получено корректно").Равно(Сущность.Дробное);
	Ожидаем.Что(ЗначенияКолонок.Получить("БулевоИстина"), "ЗначенияКолонок.БулевоИстина получено корректно").Равно(Сущность.БулевоИстина);
	Ожидаем.Что(ЗначенияКолонок.Получить("БулевоЛожь"), "ЗначенияКолонок.БулевоЛожь получено корректно").Равно(Сущность.БулевоЛожь);
	Ожидаем.Что(ЗначенияКолонок.Получить("Строка"), "ЗначенияКолонок.Строка получено корректно").Равно(Сущность.Строка);
	Ожидаем.Что(ЗначенияКолонок.Получить("Дата"), "ЗначенияКолонок.Дата получено корректно").Равно(Сущность.Дата);
	Ожидаем.Что(ЗначенияКолонок.Получить("Время"), "ЗначенияКолонок.Время получено корректно").Равно(Сущность.Время);
	Ожидаем.Что(ЗначенияКолонок.Получить("ДатаВремя"), "ЗначенияКолонок.ДатаВремя получено корректно").Равно(Сущность.ДатаВремя);
	Ожидаем.Что(ЗначенияКолонок.Получить("Ссылка"), "ЗначенияКолонок.Ссылка получено корректно").Равно(Сущность.Ссылка.Целое);
	Ожидаем.Что(ЗначенияКолонок.Получить("ДвоичныеДанные"), "ЗначенияКолонок.ДвоичныеДанные получено корректно").Равно(Сущность.ДвоичныеДанные);
КонецПроцедуры

&Тест
Процедура УдалитьСтрокиВТаблице() Экспорт
	МодельДанных = Новый МодельДанных();
	ОбъектМодели = МодельДанных.СоздатьОбъектМодели(Тип("СущностьСоВсемиТипамиКолонок"));
	Коннектор.ИнициализироватьТаблицу(ОбъектМодели);
	
	Сущность = Новый СущностьСоВсемиТипамиКолонок;
	Сущность.Целое = 1;
	
	Коннектор.Сохранить(ОбъектМодели, Сущность);
	
	Отбор = Новый Массив;
	Отбор.Добавить(Новый ЭлементОтбора("Целое", ВидСравнения.Равно, Сущность.Целое));

	Коннектор.УдалитьСтрокиВТаблице(ОбъектМодели, Отбор);

	НайденныеСтроки = Коннектор.НайтиСтрокиВТаблице(ОбъектМодели, Отбор);
	Ожидаем.Что(НайденныеСтроки, "Сущность удалилась").ИмеетДлину(0);
КонецПроцедуры

&Тест
Процедура УдалениеСущности() Экспорт
	МодельДанных = Новый МодельДанных();
	ОбъектМодели = МодельДанных.СоздатьОбъектМодели(Тип("СущностьСоВсемиТипамиКолонок"));
	Коннектор.ИнициализироватьТаблицу(ОбъектМодели);
	
	Сущность = Новый СущностьСоВсемиТипамиКолонок();
	Сущность.Целое = 1;
	Коннектор.Сохранить(ОбъектМодели, Сущность);
	
	Коннектор.Удалить(ОбъектМодели, Сущность);
	
	Отбор = Новый Массив;
	Отбор.Добавить(Новый ЭлементОтбора("Целое", ВидСравнения.Равно, Сущность.Целое));
	НайденныеСтроки = Коннектор.НайтиСтрокиВТаблице(ОбъектМодели, Отбор);
	
	Ожидаем.Что(НайденныеСтроки, "Сущность удалилась").ИмеетДлину(0);
	
КонецПроцедуры

&Тест
Процедура Автоинкремент() Экспорт
	МодельДанных = Новый МодельДанных();
	ОбъектМодели = МодельДанных.СоздатьОбъектМодели(Тип("АвтоинкрементныйКлючБезКолонок"));
	Коннектор.ИнициализироватьТаблицу(ОбъектМодели);
	
	Сущность = Новый АвтоинкрементныйКлючБезКолонок();
	Коннектор.Сохранить(ОбъектМодели, Сущность);
	
	Ожидаем.Что(Сущность.Идентификатор).Равно(1);

	Сущность = Новый АвтоинкрементныйКлючБезКолонок();
	Коннектор.Сохранить(ОбъектМодели, Сущность);
	
	Ожидаем.Что(Сущность.Идентификатор).Равно(2);

КонецПроцедуры

&Тест
Процедура СущностьМожетЗаписатьСебя() Экспорт
	// Дано
	ПодключитьСценарий("tests/fixtures/ПростойОбъект.os", "ПростойОбъект");
	КаталогБД = "./tests/jsondatabase";
	ФС.ОбеспечитьПустойКаталог(КаталогБД);
    ТипКоннектора = "КоннекторJSON";
	МенеджерСущностей = Новый МенеджерСущностей(Тип(ТипКоннектора), КаталогБД);
	МенеджерСущностей.ДобавитьКлассВМодель(Тип("ПростойОбъект"));
	МенеджерСущностей.Инициализировать();

	// Когда 
	ПростойОбъект = МенеджерСущностей.СоздатьЭлемент(Тип("ПростойОбъект"));
	ПростойОбъект.Идентификатор = "1";
	ПростойОбъект.Поле = "2";
	ПростойОбъект.Сохранить();

	// Тогда
	НайденныйПростойОбъект = МенеджерСущностей.ПолучитьОдно(Тип("ПростойОбъект"), "1");

	Ожидаем.Что(НайденныйПростойОбъект).Не_().Равно(Неопределено);
	Ожидаем.Что(НайденныйПростойОбъект.Идентификатор).Равно("1");
	Ожидаем.Что(НайденныйПростойОбъект.Поле).Равно("2");

КонецПроцедуры

&Тест
Процедура СущностьМожетПерезаписатьСебя() Экспорт
	// Дано
	ПодключитьСценарий("tests/fixtures/ПростойОбъект.os", "ПростойОбъект");
	КаталогБД = "./tests/jsondatabase";
	ФС.ОбеспечитьПустойКаталог(КаталогБД);
    ТипКоннектора = "КоннекторJSON";
	МенеджерСущностей = Новый МенеджерСущностей(Тип(ТипКоннектора), КаталогБД);
	МенеджерСущностей.ДобавитьКлассВМодель(Тип("ПростойОбъект"));
	МенеджерСущностей.Инициализировать();

	// Когда 
	ПростойОбъект = МенеджерСущностей.СоздатьЭлемент(Тип("ПростойОбъект"));
	ПростойОбъект.Идентификатор = "1";
	ПростойОбъект.Поле = "2";
	ПростойОбъект.Сохранить();
	НайденныйПростойОбъект = МенеджерСущностей.ПолучитьОдно(Тип("ПростойОбъект"), "1");
	НайденныйПростойОбъект.Поле = "3";
	НайденныйПростойОбъект.Сохранить();

	// Тогда
	НайденныйПростойОбъект = МенеджерСущностей.ПолучитьОдно(Тип("ПростойОбъект"), "1");

	Ожидаем.Что(НайденныйПростойОбъект).Не_().Равно(Неопределено);
	Ожидаем.Что(НайденныйПростойОбъект.Идентификатор).Равно("1");
	Ожидаем.Что(НайденныйПростойОбъект.Поле).Равно("3");

КонецПроцедуры

&Тест
Процедура МенеджерСущностейМожетЗаписать() Экспорт
	// Дано
	ПодключитьСценарий("tests/fixtures/ПростойОбъект.os", "ПростойОбъект");
	КаталогБД = "./tests/jsondatabase";
	ФС.ОбеспечитьПустойКаталог(КаталогБД);
    ТипКоннектора = "КоннекторJSON";
	МенеджерСущностей = Новый МенеджерСущностей(Тип(ТипКоннектора), КаталогБД);
	МенеджерСущностей.ДобавитьКлассВМодель(Тип("ПростойОбъект"));
	МенеджерСущностей.Инициализировать();

	// Когда 
	ПростойОбъект = МенеджерСущностей.СоздатьЭлемент(Тип("ПростойОбъект"));
	ПростойОбъект.Идентификатор = "1";
	ПростойОбъект.Поле = "2";
	МенеджерСущностей.Сохранить(ПростойОбъект);

	// Тогда
	НайденныйПростойОбъект = МенеджерСущностей.ПолучитьОдно(Тип("ПростойОбъект"), "1");

	Ожидаем.Что(НайденныйПростойОбъект).Не_().Равно(Неопределено);
	Ожидаем.Что(НайденныйПростойОбъект.Идентификатор).Равно("1");
	Ожидаем.Что(НайденныйПростойОбъект.Поле).Равно("2");

КонецПроцедуры

&Тест
Процедура ХранилищеСущностейМожетЗаписать() Экспорт

	// Дано
	ПодключитьСценарий("tests/fixtures/ПростойОбъект.os", "ПростойОбъект");
	КаталогБД = "./tests/jsondatabase";
	ФС.ОбеспечитьПустойКаталог(КаталогБД);
    ТипКоннектора = "КоннекторJSON";
	МенеджерСущностей = Новый МенеджерСущностей(Тип(ТипКоннектора), КаталогБД);
	МенеджерСущностей.ДобавитьКлассВМодель(Тип("ПростойОбъект"));
	МенеджерСущностей.Инициализировать();

	// Когда 

	ХранилищеПростойОбъект = МенеджерСущностей.ПолучитьХранилищеСущностей(Тип("ПростойОбъект"));

	ПростойОбъект = ХранилищеПростойОбъект.СоздатьЭлемент();
	ПростойОбъект.Идентификатор = "1";
	ПростойОбъект.Поле = "2";
	ПростойОбъект.Сохранить();

	// Тогда
	НайденныйПростойОбъект = ХранилищеПростойОбъект.ПолучитьОдно("1");

	Ожидаем.Что(НайденныйПростойОбъект).Не_().Равно(Неопределено);
	Ожидаем.Что(НайденныйПростойОбъект.Идентификатор).Равно("1");
	Ожидаем.Что(НайденныйПростойОбъект.Поле).Равно("2");

КонецПроцедуры