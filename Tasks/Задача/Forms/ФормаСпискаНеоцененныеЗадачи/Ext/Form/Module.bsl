﻿





&НаСервереБезКонтекста
Процедура ОбновитьСтатусЗадач(МассивЗадач, НовыйСтатус)
	Для каждого ТекЗадача Из МассивЗадач Цикл
		
		ЗадачаОбъект = ТекЗадача.ПолучитьОбъект();
		   //Проверка на смену статуса
		Если ЗадачаОбъект.Статус = НовыйСтатус Тогда
			
			Продолжить
			 
		КонецЕсли;
		
	 	  		
		   //Проверка на возврат задачи из статуса "исполнена" в другой
		   
		Если ЗадачаОбъект.Статус = Перечисления.Статусы.Исполнена И НЕ(НовыйСтатус = Перечисления.Статусы.Исполнена)   Тогда
		    
			ЗадачаОбъект.Выполнена = Ложь;
			ЗадачаОбъект.ДатаЗавершения = "";
			
		КонецЕсли;

		ЗадачаОбъект.Статус = НовыйСтатус;
		  //Проверка на переход задачи в статус "исполнена"  		
		Если НовыйСтатус = Перечисления.Статусы.Исполнена Тогда
			ЗадачаОбъект.Выполнена = Истина;
			ЗадачаОбъект.ДатаЗавершения = ТекущаяДата();
		КонецЕсли;	
		
		Попытка
			ЗадачаОбъект.Записать();
		Исключение 
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = "Не удалось изменить статус задачи" + "по причине" + ОписаниеОшибки();
			Сообщение.Сообщить();
		КонецПопытки;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСтатусыЗадачКлиент(МассивЗадач, НовыйСтатус)

	 Если ТипЗнч(МассивЗадач) = Тип("Массив")  Тогда
		 ОбновитьСтатусЗадач(МассивЗадач, НовыйСтатус);
	 КонецЕсли;
	 
	 ОповеститьОбИзменении(Тип("ЗадачаСсылка.Задача"));


КонецПроцедуры 
 

&НаКлиенте
Процедура НоваяПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	 ОбновитьСтатусыЗадачКлиент( ПараметрыПеретаскивания.Значение, ПредопределенноеЗначение("Перечисление.Статусы.Новая"));
		 
КонецПроцедуры

&НаКлиенте
Процедура ВРаботеПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	ОбновитьСтатусыЗадачКлиент( ПараметрыПеретаскивания.Значение, ПредопределенноеЗначение("Перечисление.Статусы.ВРаботе"));

КонецПроцедуры

&НаКлиенте
Процедура ИсполненаПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	ОбновитьСтатусыЗадачКлиент( ПараметрыПеретаскивания.Значение, ПредопределенноеЗначение("Перечисление.Статусы.Исполнена"));

КонецПроцедуры


&НаСервере
Процедура ПриОткрытииНаСервере()
	
	//Новая.Параметры.УстановитьЗначениеПараметра("ТекущийПользователь",ПараметрыСеанса.ТекущийПользователь);
	//ВРаботе.Параметры.УстановитьЗначениеПараметра("ТекущийПользователь",ПараметрыСеанса.ТекущийПользователь);
	//Исполнена.Параметры.УстановитьЗначениеПараметра("ТекущийПользователь",ПараметрыСеанса.ТекущийПользователь);
	
	 	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Задача.Ссылка КАК Ссылка,
		|	Задача.ВерсияДанных КАК ВерсияДанных,
		|	Задача.ПометкаУдаления КАК ПометкаУдаления,
		|	Задача.Номер КАК Номер,
		|	Задача.Дата КАК Дата,
		|	Задача.Наименование КАК Наименование,
		|	Задача.Выполнена КАК Выполнена,
		|	Задача.Описание КАК Описание,
		|	Задача.СрокВыполнения КАК СрокВыполнения,
		|	Задача.Статус КАК Статус,
		|	Задача.ДатаЗавершения КАК ДатаЗавершения,
		|	Задача.ЧасыРук КАК ЧасыРук,
		|	Задача.ТекущийПользователь КАК ТекущийПользователь,
		|	Задача.Исполнитель КАК Исполнитель,
		|	Задача.Создатель КАК Создатель,
		|	Задача.Представление КАК Представление
		|ИЗ
		|	Задача.Задача КАК Задача
		|ГДЕ
		|	Задача.ЧасыРук = 0";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		Если Выборка.СрокВыполнения <= ТекущаяДата()+86400 и НЕ(Выборка.Статус = Перечисления.Статусы.Исполнена)  Тогда
			               //Проверка на срок исполнения в 1 день

			Если Выборка.СрокВыполнения >= ТекущаяДата() Тогда
			
				   Сообщить("Для выполнения задачи " + Выборка.Наименование + " осталось меньше 1 дня" );

			
			Иначе        	//Проверка на просрочку срока выполнения

			
				        Сообщить("Срок сдачи задачи " + Выборка.Наименование + " просрочен");

			
			КонецЕсли;
					
		КонецЕсли;

	КонецЦикла;
	


	
			
			
			
		
	  	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ПриОткрытииНаСервере();
	КонецПроцедуры

&НаКлиенте
Процедура МоиЗадачи(Команда)
	
		ОткрытьФорму("Задача.Задача.Форма.ФормаСпискаЗадачТекПользователя");

	КонецПроцедуры






		
