define [ 'moment', 'app', 'jquery-ui' ], (moment)->
  angular.module('app').directive 'calendar', ()->
    {
      restrict: 'A'
      require: 'ngModel'
      scope:
        calendarOptions: "="
        minDate: '&'
        maxDate: '&'
      link: (scope, element, attrs, ctrl)->
        e = $(element)
        
        # Выставляем стандартные настройки приложения и настройки из аттрибутов
        options =
          ## Настройки директивы
          # Кнопка вызывающая календарь. При указании данной настройки основной блок календаря скрывается
          pickerButton: attrs.pickerButton
          # Указание формата парсинга moment-js при преобразовании jquery-ui даты в собственную 
          # Используется при несовпадении формата jquery-ui и формата moment-js
          parseFormatMoment: attrs.parseFormatMoment
          # Формат хранения данных в модели (формат moment-js)
          dateFormatMoment: attrs.dateFormatMoment
          ## Настройки jquery-ui календаря
          constrainInput: attrs.constrainInput
          dateFormat: attrs.dateFormat
          defaultDate: attrs.defaultDate
          changeYear: true
          yearRange: '-100:+10'
          onSelect: (date)->
            # Применение изменений к модели без $setViewValue не всегда корректно отрабатывает в firefox
            ctrl.$setViewValue date

        # Применяем настройки календаря переданные через calendarOptions
        if scope.calendarOptions
          options = angular.extend options, scope.calendarOptions

        # Приводим настройки к нужному формату и инициализируем значения по умолчанию
        options.dateFormatMoment = if options.dateFormatMoment is undefined then 'DD MMMM YYYY' else options.dateFormatMoment
        options.defaultDate = if options.defaultDate is undefined then undefined else moment(options.defaultDate, options.dateFormatMoment).toDate()

        # Инициализируем календарь
        e.datepicker options

        if attrs.minDate isnt undefined
          # Добавляем валидаторы angularJs
          # Обновляем валидатор maxDate у Jquery компонента
          scope.$watch scope.minDate, (min_date)->
            if !!min_date
              ctrl.$validators['calendar-min'] = (modelValue, viewValue) ->
                value = modelValue || viewValue
                !moment(min_date, options.dateFormatMoment).isAfter moment(value, options.dateFormatMoment)
              e.datepicker 'option', 'minDate', moment(min_date, options.dateFormatMoment).toDate()

        if attrs.maxDate isnt undefined
          # Добавляем валидаторы angularJs
          # Обновляем валидатор maxDate у Jquery компонента
          scope.$watch scope.maxDate, (max_date)->
            if !!max_date
              ctrl.$validators['calendar-max'] = (modelValue, viewValue) ->
                value = modelValue || viewValue
                !moment(max_date, options.dateFormatMoment).isBefore moment(value, options.dateFormatMoment)
              e.datepicker 'option', 'maxDate', moment(max_date, options.dateFormatMoment).toDate()

        # Обработчик pickerButton
        if options.pickerButton isnt undefined
          e.css
            width: 0
            height: 0
            border: 0
          $(document.body).off 'click', options.pickerButton
          $(document.body).on 'click', options.pickerButton, ->
            e.datepicker('show')
    }
      