// Для части полей допустимо высчитывать значение колонки при вставке записи в таблицу.
// Например, для первичных числовых ключей обычно не требуется явное управление назначаемыми идентификаторами.
//
// Референсная реализация коннекторов на базе SQL поддерживает единственный тип генератора значений - `AUTOINCREMENT`.
//
// Применяется на поле класса.
//
// Пример:
// 
// &Идентификатор
// &ГенерируемоеЗначение
// Перем ИД;
//
&Аннотация("ГенерируемоеЗначение")
Процедура ПриСозданииОбъекта()
КонецПроцедуры
