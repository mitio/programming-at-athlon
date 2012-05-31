<?

class Cup {
	function __construct($capacity, $used) {
		$this->capacity = $capacity;
		$this->used = $used;
	}

	function gulp() {
		$amount = min($this->used, 30);
		$this->used -= $amount;
		echo "Gulped $amount ml!\n";
	}

	function plug($how_much) {
		$plugged = min($how_much, $this->capacity - $this->used);
		$extra = $how_much - $plugged;
		$this->used += $plugged;
		echo "Plugged $plugged ml, spilled $extra!\n";
	}

	function peek() {
		echo "Used {$this->used} ml of {$this->capacity} ml.\n";
	}
}

echo "Started!\n";

$coffee_cup = new Cup(100, 70);
$beer_mug = new Cup(1000, 1000);

$coffee_cup->peek();
$coffee_cup->gulp();
$coffee_cup->gulp();
$coffee_cup->gulp();
$coffee_cup->gulp();
$coffee_cup->peek();
$coffee_cup->plug(125);
