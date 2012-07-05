## Материали и ресурси

Теми:

- Кратък преговор на нещата до момента
- Основни типове данни в езика
- Списъци, множества и операции с тях (`#length`, `#<<`, `#[]`, `#+` и др.)
- Обща концепция за класове, наследници, функционалност и данни
- Двоични дървета и ефективно търсене в тях
- Обхождане на списъци с `Array#each`
- Прескачане към следващия елемент в `#each` посредством `next`, както и прекъсване на обхождането с `break`

Докъде стигнахме от презентациите:

- http://fmi.ruby.bg/lectures/02-arrays-hashes-functions#30

Документация на списъците в Ruby (клас `Array`) може да намерите тук:

- http://www.ruby-doc.org/core-1.9.3/Array.html

Документация на множества в Ruby (клас `Set`) може да намерите тук:

- http://www.ruby-doc.org/stdlib-1.9.3/libdoc/set/rdoc/Set.html

## За домашно

### 1. FizzBuzz със списъци

Целта ви е да направите функция със следната сигнатура (дефиниция):

	fizzbuzz_on_lists(list)

Тя трябва да приема един аргумент, който се очаква да е списък. След това започва да обхожда списъка
и се държи като стандартна fizzbuzz-имплементация:

* За числа, делящи се на 3, изкарва на екрана текста `fizz`
* За числа, делящи се на 5, изкарва на екрана текста `buzz`
* За числа, делящи се на 3 и на 5, изкарва на екрана текста `fizzbuzz`
* За всички останали числа извежда самото число.

Функцията трябва да връща `nil` след като приключи работата си.

В списъка е възможно освен числа, да има и един специален символ — `:quit`. Ако функцията ви се натъкне
на този символ, тя трябва да прекрати изпълнението си, без да извежда нищо повече на екрана.

Може да разчитате, че в списъка няма да има други типове данни.

### 2. Данни и списъци в списъци, в списъци...

Разполагаме с един списък от данни, имащ неопределена дължина. Всеки елемент от списъка ще е друг списък
с поне един елемент. Първият елемент на този вложен списък ще разглеждаме като команда, която трябва да
бъде изпълнена, а евентуалните следващи елементи във вложения списък ще бъдат разглеждани и използвани
като аргументи на въпросната команда. Командата ще бъде символ.

Задачата ви е да напишете функция, която да има следната сигнатура:

	process_commands(commands)

Тоест, приема един аргумент — списъка с команди — и връща `nil`, освен ако някоя команда не изисква друго.
Функцията трябва да обхожда списъка елемент по елемент (т.е. команда по команда) и да ги изпълнява подред.

Трябва да поддържате следните команди:

- `:puts`, която да извежда на екрана подадения й аргумент (т.е. втория елемент от вложения списък)
- `:inspect` командата приема един аргумент, извиква метода му `inspect` и го извежда на екрана
- `:object_id` командата приема един аргумент, взима му `object_id`-то и го извежда на екрана
- `:call` е команда с два аргумента (съответно втория и третия елемент от вложения списък); вторият елемент се очаква да е анонимна функция, която трябва да бъде извикана с аргумент третия елемент от списъка и резултатът от изпълнението й трябва да бъде изведен на екрана
- `:same_object?` е команда, която приема два аргумента и извежда на екрана `true`, ако са два еднакви обекта и `false` в противен случай
- `:map_and_print` е команда, приемаща два аргумента; първият е списък (да го наречем `list_to_be_mapped`), а вторият е анонимна функция, която приема един аргумент; тази функция трябва да се извика за всеки един от елементите на списъка `list_to_be_mapped` и резултатът й да замени съответния елемент (подсказка: ползвайте [`Array#map`](http://www.ruby-doc.org/core-1.9.3/Array.html#method-i-map)); резултатния списък след "map"-ването трябва да бъде преобразуван към string посредством метода [`Array#join`](http://www.ruby-doc.org/core-1.9.3/Array.html#method-i-join) така: `some_resulting_list.join(', ')` и този string трябва да бъде изведен на екрана.
- `:stop` е команда без аргументи, която кара `process_commands` да прекрати работата си
- ако списъкът свърши, без да се срещне командата `:stop`, `process_commands` отново прекратява работата си

Пример за списък с команди, който вашата функция ще приема като аргумент:

	[
	  [:puts, 'Started.'],
	  [:inspect, [1, :something, '2']],
	  [:call, lambda { |message| "Your message was: #{message}" }, "Hi!"],
	  [:same_object?, 'wat', 'wat'],
	  [:same_object?, :wat, :wat],
	  [:map_and_print, [1, 2, 3, 'Go!'], lambda { |element| element.to_s }],
	  [:puts, 'About to end...'],
	  [:stop],
	  [:puts, 'Never printed!'],
	]

Пример за очакван изход на екрана след изпълнението на `process_commands` над този списък с команди:

	Started.
	[1, :something, "2"]
	Your message was: Hi!
	false
	true
	1, 2, 3, Go!
	About to end...

Ако някои команди ви затрудняват и не успеете да ги реализирате, просто ги пропуснете. Ще ги обсъдим
на следващата сбирка. Важно е да покажете нещо работещо, макар и не с всички команди.

## Как да предавате домашното си

Вероятно ще е най-удобно да запишете кода си в [Gist-секцията на GitHub](https://gist.github.com/)
и да ми пратите линк към резултатния Gist. Приемам всичко без прикачени .doc файлове в мейли.

## Срок

Срокът да ми пратите решенията си е до 18:00 на 5-ти юли 2012.