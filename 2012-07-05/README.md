## Материали и ресурси

Докъде стигнахме от презентациите:

- http://fmi.ruby.bg/lectures/02-arrays-hashes-functions#48

Документация на речниците в Ruby (клас `Hash`) може да намерите тук:

- http://www.ruby-doc.org/core-1.9.3/Hash.html

Хвърлете едно око какви методи има там.

Решения на домашното от миналия път на вашите колеги, за който иска да си ги прегледа на спокойствие:

- https://gist.github.com/3032979
- https://gist.github.com/3053966
- https://gist.github.com/3053874
- https://gist.github.com/3052879
- https://gist.github.com/3052512
- http://pastie.org/4197589
- http://pastie.org/4197590
- http://pastebin.com/TGA8kRY1
- http://pastebin.com/t74nhewu

## Ново домашно

Условието на новото домашно ще намерите тук: http://fmi.ruby.bg/tasks/1

Единствената промяна е в частта за `Array#index_by` — не отпада, остава и тя, но със следното променено условие:

### Array#index_by

Добавете метод `index_by` в `Array`, приемащ анонимна функция и връщащ хеш, в който всяка стойност
е елемент от масива, а ключът е оценката (върнатата стойност) на анонимната функция, извикана с аргумент
въпросния елемент:

	['John Coltrane', 'Miles Davis'].index_by(lambda { |name| name.split(' ').last })
	# Очакван резултат: {'Coltrane' => 'John Coltrane', 'Davis' => 'Miles Davis' }

	%w[foo larodi bar].index_by(lambda { |s| s.length })
	# Очакван резултат: {3 => 'bar', 6 => 'larodi'}

Ако анонимната функция оценява няколко елемента с една и съща стойност, ползвайте последнния елемент
като финална стойност за дадения ключ.

Решенията ги пращайте по същия начин, срокът е като преди — до сбирката следващия четвъртък.
