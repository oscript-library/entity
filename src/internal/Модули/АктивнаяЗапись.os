#Использовать decorator

Функция ТипСущности(Сущность) Экспорт
	ТипСущности = ТипЗнч(Сущность);
	Если ТипСущности = Тип("Сценарий") Тогда
		ТипСущности = ОбработкаДекоратора.ИсходныйТип(Сущность);
	КонецЕсли;

	Возврат ТипСущности;
КонецФункции

Функция СоздатьИзМенеджера(ОбъектМодели, МенеджерСущностей) Экспорт
	Сущность = Новый(ОбъектМодели.ТипСущности());
	
	Декоратор = Новый КонструкторДекоратора(Сущность)
		.ДобавитьИмпортПоИмени("decorator")
		.ДобавитьПриватноеПоле("_МенеджерСущностей", МенеджерСущностей)
		.ДобавитьПриватноеПоле("_ОбъектМодели", ОбъектМодели)
		.ДобавитьМетод(
			"Прочитать", 
			"_ТипСущности = ОбработкаДекоратора.ИсходныйТип(ЭтотОбъект);
			|_ДанныеСущности = _МенеджерСущностей.ПолучитьОдно(
			|	_ТипСущности,
			|	_ОбъектМодели.ПолучитьЗначениеИдентификатора(ЭтотОбъект)
			|);
			|ОбработкаДекоратора.СинхронизироватьПоля(_ДанныеСущности, ЭтотОбъект);"
		)
		.ДобавитьМетод(
			"Сохранить",
			"_МенеджерСущностей.Сохранить(ЭтотОбъект);"
		)
		.ДобавитьМетод(
			"Удалить", 
			"_МенеджерСущностей.Удалить(ЭтотОбъект);"
		)
		.Построить();
	
	Возврат Декоратор;
КонецФункции

Функция СоздатьИзХранилища(ОбъектМодели, ХранилищеСущностей) Экспорт
	Сущность = Новый(ОбъектМодели.ТипСущности());
	
	Декоратор = Новый КонструкторДекоратора(Сущность)
		.ДобавитьИмпортПоИмени("decorator")
		.ДобавитьПриватноеПоле("_ХранилищеСущностей", ХранилищеСущностей)
		.ДобавитьПриватноеПоле("_ОбъектМодели", ОбъектМодели)
		.ДобавитьМетод(
			"Прочитать", 
			"_ДанныеСущности = _ХранилищеСущностей.ПолучитьОдно(_ОбъектМодели.ПолучитьЗначениеИдентификатора(ЭтотОбъект));
			|ОбработкаДекоратора.СинхронизироватьПоля(_ДанныеСущности, ЭтотОбъект);"
		)
		.ДобавитьМетод(
			"Сохранить",
			"_ХранилищеСущностей.Сохранить(ЭтотОбъект);"
		)
		.ДобавитьМетод(
			"Удалить", 
			"_ХранилищеСущностей.Удалить(ЭтотОбъект);"
		)
		.Построить();
	
	Возврат Декоратор;
КонецФункции