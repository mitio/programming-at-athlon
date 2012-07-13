## Материали и ресурси

Днес разглеждахме единствено домашните и езикови конструкции около тях.

Вашите решения:

- https://gist.github.com/3097349 (Розалия)
- https://gist.github.com/3097696 (Криси)
- https://gist.github.com/3089390 (Крум)
- https://gist.github.com/3086491 (Пламен)
- https://gist.github.com/3099001 (Еленко)
- https://gist.github.com/3098851 (Крис)

## Ново домашно

Представете си, че имаме каталог с музиката, която слушаме. Искаме да му задаваме въпроси от рода на:

* Дай ми всички песни на този изпълнител.
* Дай ми всички меланхолични джаз песни.
* Дай ми всички песни, които имат буквата “е”.
* Дай ми всички песни, в които има саксофон.

Всяка песен в нашия каталог има следните неща:

* name – Име (`"My Favourite Things"`)
* artist – Изпълнител или композитор (`"John Coltrane"`)
* genre – Жанр (`"Jazz"`)
* subgenre – Опционален поджанр: (`"Bebop"`)
* tags – Етикети (множество от низове `['saxophone', 'popular', 'jazz', 'bebop', 'cover']`)

Песните са записани в текстов низ със следния формат:

	My Favourite Things.          John Coltrane.      Jazz, Bebop.        popular, cover
	Greensleves.                  John Coltrane.      Jazz, Bebop.        popular, cover
	Alabama.                      John Coltrane.      Jazz, Avantgarde.   melancholic
	Acknowledgement.              John Coltrane.      Jazz, Avantgarde
	Afro Blue.                    John Coltrane.      Jazz.               melancholic
	'Round Midnight.              John Coltrane.      Jazz
	My Funny Valentine.           Miles Davis.        Jazz.               popular
	Tutu.                         Miles Davis.        Jazz, Fusion.       weird, cool
	Miles Runs the Voodoo Down.   Miles Davis.        Jazz, Fusion.       weird
	Boplicity.                    Miles Davis.        Jazz, Bebop
	Autumn Leaves.                Bill Evans.         Jazz.               popular
	Waltz for Debbie.             Bill Evans.         Jazz
	'Round Midnight.              Thelonious Monk.    Jazz, Bebop
	Ruby, My Dear.                Thelonious Monk.    Jazz.               saxophone
	Fur Elise.                    Beethoven.          Classical.          popular
	Moonlight Sonata.             Beethoven.          Classical.          popular
	Pathetique.                   Beethoven.          Classical
	Toccata e Fuga.               Bach.               Classical, Baroque. popular
	Goldberg Variations.          Bach.               Classical, Baroque
	Eine Kleine Nachtmusik.       Mozart.             Classical.          popular, violin

* По една песен на ред
* Стойностите са разделени с точка (.), като може да има произволно количество whitespace (интервали и табове) около точката-разделител.
* Може да има повторения, както в имена на песни, така и на артисти
* Жанрът и поджанрът са в едно поле, като вторият е опционален. Ако го има, разделени са със запетая.
* Последното поле е списък от етикети, разделени със запетаи. Може да е празно.
* Освен от изрично изброените, една песен може да получава етикети от две други места – артист и жанрове.

Знаем, че всички песни на Колтрейн имат саксофон, а пък Бах пише полифонична музика за пиано. Затова, освен този текстов низ, имаме и следния речник:

```Ruby
{
  'John Coltrane' => ['saxophone'],
  'Bach' => ['piano', 'polyphony'],
}
```

Горното казва, че всички песни на Колтрейн трябва да имат етикет `saxophone`, а всички на Бах – етикети `piano` и `polyphony`.

Жанрът и поджанрът трябва също да дават етикети. Ако една песен е “Jazz, Bebop”, тя трябва да получи етикетите `jazz` и `bebop` (изцяло малки букви). Ако е само “Jazz”, получава само един етикет – `jazz`.

## Идеята

Първо трябва да напишете метод със следната сигнатура:

```Ruby
collection = collection_from_string(songs_as_string, artist_tags)
```

* Първият аргумент `songs_as_string` е текстов низ, съдържащ каталог с песни в показания по-горе формат.
* Вторият е речник, съпоставящ име на артист (низ) с етикети (списък от низове), които всички негови песни трябва да имат, както беше обяснено по-горе.
* Методът трябва да връща нещо, което ще ползвате по-нататък в друг метод. Какво е то, мен не ме интересува (дали е списък, хеш или нещо друго). Вие решавате. Засега се придържайте към вградените в Ruby типове, не пишете собствени класове.

Следващата ви задача е да напишете метод `find_in_collection`, имащ следния вид:

```Ruby
songs = find_in_collection(collection, criteria)
```

* Първият му аргумент е резултатът от `collection_from_string`, т.е. вече обработената музикална колекция, намираща се в удобен за вашата вътрешна употреба формат. Вторият аргумент на метода — `criteria` — е хеш, който ще задава критерии, по които да филтрирате песните от музикалната колекция. Методът `find_in_collection` трябва да връща списък от хешове, като всеки върнат хеш трябва да отговаря на една песен (ще ги наричаме *хеш-песен*).

Всеки хеш-песен трябва да има следните ключове (ако предположим, че променливата `song` сочи към такъв хеш-песен):

```Ruby
# Пример за следната песен:
# My Favourite Things.    John Coltrane.      Jazz, Bebop.        popular
song[:name]     # => "My Favourite Things"
song[:artist]   # => "John Coltrane"
song[:genre]    # => "Jazz"
song[:subgenre] # => "Bebop"
song[:tags]     # => ['popular', 'jazz', 'bebop', 'saxophone']

# Пример за следната песен:
# Eine Kleine Nachtmusik. Mozart.             Classical.          popular
song[:name]     # => "Eine Kleine Nachtmusik"
song[:artist]   # => "Mozart"
song[:genre]    # => "Classical"
song[:subgenre] # => nil
song[:tags]     # => ['classical', 'popular']
```

Няколко примера как трябва да работи `find_in_collection`, ако предположим, че в променливата `collection` стои резултата от предишно извикване на `collection_from_string(…)`:

```Ruby
# Намира всички песни с етикет jazz:
find_in_collection(collection, {tags: 'jazz'})

# Намира всички песни, които имат двата етикета jazz и piano:
find_in_collection(collection, {tags: ['jazz', 'piano']})

# Намира всички песни, които имат етикет jazz и нямат етикет piano:
find_in_collection(collection, {tags: ['jazz', 'piano!']})

# Намира всички популярни песни на Джон Колтрейн:
find_in_collection(collection, {tags: 'popular', artist: 'John Coltrane'})

# Връща имена на песни, които започват с думичката "My":
find_in_collection(collection, {filter: ->(song) { song[:name].start_with?('My') }})
```

Както споменахме, очакваме върнатият резултат да е списък от хеш-песни (с посочените по-горе ключове). Разбира се, ако няма съвпадения, отговарящи на поисканите критерии, ще връщате празен списък. Например, валиден резултат, съдържащ две песни и върнат от `find_in_collection`, е следното (форматирано в четим вид):

```Ruby
[
	{
		name: "Eine Kleine Nachtmusik",
		artist: "Mozart",
		genre: "Classical",
		subgenre: nil,
		tags: ['classical', 'popular'],
	},
	{
		name: "My Favourite Things",
		artist: "John Coltrane",
		genre: "Jazz",
		subgenre: "Bebop",
		tags: ['popular', 'jazz', 'bebop', 'saxophone'],
	},
]
```

## Спецификацията

* Метод `collection_from_string(songs_as_string, artist_tags)`, отговарящ на изискванията, описани по-горе.
* Метод `find_in_collection(collection, criteria)`.

В `criteria` стои хеш, чиито ключове и стойности дефинират кои песни да се търсят по следните правила:

* `criteria[:tags]` – Съдържа низ или списък от низове. Ограничава резултатите до песни, притежаващи всички етикети. Ако някой етикет завършва на удивителна (!), ограничава песните до тези, които нямат този етикет. Очевидно, етикетите в `songs_as_string` няма да съдържат удивителна в края на оригиналното си име, за да може този критерий да работи.
* `criteria[:name]` – Низ. Ограничава до песни, чието име съвпада с низа.
* `criteria[:artist]` – Аналогично на предното, но за име на изпълнител.
* `criteria[:filter]` – Ламбда, приемаща един аргумент, който е хеш-песен (с изброените по-горе ключове) и връщаща булева стойност. `find_in_collection` трябва да ограничи резултатите до песни, за които `criteria[:filter]` се оценява до истина.
* Редът на върнатите обекти няма значение.
* Можете да подавате повече от един ключ в `criteria`, което значи да подадете няколко критерия за търсене наведнъж. Критериите са конюнктивни. Търсят се песни, които отговарят на всички.
* Ако `find_in_collection` се извика с празен речник за `criteria`, връща всички песни (всички артисти, всички жанрове и т.н.).

## Подсказки

* Помагайте си с документацията: [документация на Array](http://www.ruby-doc.org/core-1.9.3/Array.html), [документация на Hash](http://www.ruby-doc.org/core-1.9.3/Hash.html) и [документация на String](http://ruby-doc.org/core-1.9.3/String.html).
* Разгледайте какво правят `Array(1)`, `Array([1, 2])` и `String#lines`.
* Ако желаете, ползвайте свободно `map`, `select`/`reject` и прочее. Документация за тях може да намерите при `Array` както и в [Enumerable](http://ruby-doc.org/core-1.9.3/Enumerable.html). Например, ако искате за всеки ред от входа да създадете песен, това може да стане с `#map`. Ако искате да филтрирате песните по критерий, това става със `#select`.
